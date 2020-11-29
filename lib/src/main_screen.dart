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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
            ),
            if (!_signedIn)
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
    );
  }
}
