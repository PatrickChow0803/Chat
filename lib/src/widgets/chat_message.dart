import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatMessage extends StatelessWidget {
  final int index;
  final Map<String, dynamic> data;

  const ChatMessage({Key key, this.index, this.data}) : super(key: key);
//  final bool showAvatar;

  @override
  Widget build(BuildContext context) {
    int timeInMillis = data['timestamp'];
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    String formattedDate = DateFormat.yMMMd().format(date);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
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
        ),
        Container(margin: EdgeInsets.only(right: 10, top: 0), child: Text(formattedDate)),
      ],
    );
  }
}
