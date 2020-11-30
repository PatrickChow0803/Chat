import 'package:chat/src/widgets/chat_message_other.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageWall extends StatelessWidget {
  final List<QueryDocumentSnapshot> messages;

  const MessageWall({Key key, this.messages}) : super(key: key);

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
//        return ListTile(
//          title: Text(messages[index].data()['value']),
//        );
        return ChatMessageOther(
          data: messages[index].data(),
          index: index,
          showAvatar: shouldDisplayAvatar(index),
        );
      },
    );
  }
}
