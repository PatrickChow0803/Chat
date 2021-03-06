import 'package:chat/src/widgets/chat_message.dart';
import 'package:chat/src/widgets/chat_message_other.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// This is the widget for the user them self
class MessageWall extends StatelessWidget {
  final List<QueryDocumentSnapshot> messages;

  // Data Type is String since that's the data type of the Document's ID
  final ValueChanged<String> onDelete;

  const MessageWall({Key key, this.messages, this.onDelete}) : super(key: key);

  // If the author were to send multiple messages, prevent the avatar from displaying from future messages
  bool shouldDisplayAvatar(int index) {
    if (index == 0) return true;

    // Get the author_Id from the current message and the previous message
    final previousId = messages[index - 1].data()['author_id'];
    final authorId = messages[index].data()['author_id'];

    // If they're not the same author_Id, then display the avatar
    return authorId != previousId;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final data = messages[index].data();
        final user = FirebaseAuth.instance.currentUser;

        // Check to see if the message that is about to be sent is from the same user or not
        if (user != null && user.uid == data['author_id']) {
          return Dismissible(
            onDismissed: (_) {
              onDelete(messages[index].id);
            },
            key: ValueKey(data['timestamp']),
            child: ChatMessage(
              index: index,
              data: data,
            ),
            background: Container(
              color: Colors.red,
            ),
          );
        }
        return ChatMessageOther(
          data: data,
          index: index,
          showAvatar: shouldDisplayAvatar(index),
        );
      },
    );
  }
}
