import 'package:chat/src/widgets/message_form.dart';
import 'package:chat/src/widgets/message_wall.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

import 'auth/android_auth_provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(title: 'Chat'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _signedIn = false;

  void _signIn() async {
    try {
      final creds = await AuthProvider().signInWithGoogle();
      print(creds);

      setState(() {
        _signedIn = true;
      });
    } catch (e) {
      print('Login Failed: $e');
    }
  }

  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    setState(() {
      _signedIn = false;
    });
  }

  void _addMessage(String value) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance.collection('chat_messages').add({
        'author': user.displayName ?? 'Anonymous',
        'author_id': user.uid,
        'photo_url': user.photoURL ?? 'https://placehold.it/100x100',
        'timestamp': Timestamp.now().millisecondsSinceEpoch,
        'value': value,
      });
    }
  }

  void _deleteMessage(String docId) async {
    await FirebaseFirestore.instance.collection('chat_messages').doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          if (_signedIn)
            IconButton(
              padding: EdgeInsets.symmetric(horizontal: 15),
              icon: Icon(Icons.logout),
              onPressed: _signOut,
            )
        ],
      ),
//      backgroundColor: Color(0xffdee2d6),
      body: Container(
        color: Colors.grey[300],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                // GET THE SNAPSHOTS FROM FIRESTORE'S CHAT_MESSAGE COLLECTION
                stream: FirebaseFirestore.instance
                    .collection('chat_messages')
                    // SORT THE MESSAGES BY TIMESTAMP
                    .orderBy('timestamp')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.docs.isEmpty) {
                      return Center(
                        child: Text('No Messages'),
                      );
                    }
                    // Displays all of the data for the first doc
//                  return Text(snapshot.data.docs[0].data().toString());
                    return MessageWall(
                      messages: snapshot.data.docs,
                      onDelete: _deleteMessage,
                    );
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )),
              if (_signedIn)
                MessageForm(
                    // value is the callback value from MessageForm
                    onSubmit: _addMessage)
              else
                Container(
                  child: SignInButton(
                    Buttons.Google,
                    onPressed: _signIn,
                    padding: EdgeInsets.all(3),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
