import 'package:flutter/material.dart';

class MessageForm extends StatefulWidget {
  // This is used to send back the information to the parent widget. Which in this case is in main_screen
  // So the information is passed up the widget tree
  final ValueChanged<String> onSubmit;

  const MessageForm({Key key, this.onSubmit}) : super(key: key);
  @override
  _MessageFormState createState() => _MessageFormState();
}

class _MessageFormState extends State<MessageForm> {
  final _messageController = TextEditingController();
  String _message;

  void _onPressed() {
    widget.onSubmit(_message);
    print(_message);
    _message = '';
    _messageController.clear();
    // used to change the color of the send button to grey.
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
//      color: Colors.blue,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
              child: TextField(
            controller: _messageController,
            maxLines: 3,
            minLines: 1,
            decoration: InputDecoration(
              hintText: 'Type a message',
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.all(10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (message) {
              setState(() {
                _message = message;
              });
            },
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
            // If there's no message, prevent the onPressed functionality from working
            onPressed: _message == null || _message.isEmpty ? null : _onPressed,
            fillColor:
                _message == null || _message.isEmpty ? Colors.grey : Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          )
        ],
      ),
    );
  }
}
