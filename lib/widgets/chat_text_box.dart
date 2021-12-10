import 'package:flutter/material.dart';

class ChatTextBox extends StatelessWidget {
  const ChatTextBox(
      {Key? key,
      required this.controllerText,
      required this.onChange,
      required this.onPressed})
      : super(key: key);

  final TextEditingController controllerText;
  final Function onChange;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 10,
          child: TextField(
            controller: controllerText,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            onChanged: (text) => onChange(text),
            decoration: InputDecoration(
              hintText: "Escreva sua mensagem...",
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  onPressed();
                },
              ),
            ),
          ),
        ),
      ],
    );
    ;
  }
}
