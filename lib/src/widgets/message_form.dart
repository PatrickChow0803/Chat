import 'package:flutter/material.dart';

class MessageForm extends StatefulWidget {
  @override
  _MessageFormState createState() => _MessageFormState();
}

class _MessageFormState extends State<MessageForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
//      color: Colors.blue,
      child: Row(
        children: [
          Expanded(
              child: TextField(
            decoration: InputDecoration(
                hintText: 'Type a message',
                fillColor: Colors.white,
                filled: true,
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                )),
          )),
          SizedBox(width: 5),
          RawMaterialButton(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: const Text(
                'SEND',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            onPressed: () {},
            fillColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          )
        ],
      ),
    );
  }
}
