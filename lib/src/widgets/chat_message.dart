import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final int index;
  final Map<String, dynamic> data;

  const ChatMessage({Key key, this.index, this.data}) : super(key: key);
//  final bool showAvatar;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 300.0),
            decoration:
                BoxDecoration(color: Colors.blueGrey, borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: Text(
              data['value'],
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
