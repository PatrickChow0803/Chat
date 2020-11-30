import 'package:flutter/material.dart';

// This is how messages will appear coming from other people
class ChatMessageOther extends StatelessWidget {
  final int index;
  final Map<String, dynamic> data;
  final bool showAvatar;

  ChatMessageOther({this.index, this.data, this.showAvatar = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      child: Row(
        // makes it so that the widgets line up to the top
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showAvatar)
            CircleAvatar(
              backgroundImage: NetworkImage(data['photo_url']),
            )
          else
            SizedBox(width: 40),
          SizedBox(width: 10.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),

            // Limits how big the container is to become
            constraints: BoxConstraints(maxWidth: 300.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              // Makes the text move over to the left of container
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${data['author']} said: ',
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 5.0),
                Text(data['value']),
              ],
            ),
          )
        ],
      ),
    );
  }
}
