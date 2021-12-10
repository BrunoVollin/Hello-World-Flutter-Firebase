import 'package:flutter/material.dart';
import 'package:flutter_firebase/model/message.dart';

import 'crud_card.dart';

class MessageList extends StatelessWidget {
  const MessageList(
      {Key? key,
      required this.messageData,
      required this.updateMessage,
      required this.deleteMessage})
      : super(key: key);
  final Function updateMessage;
  final Function deleteMessage;
  final messageData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: messageData,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("You have a error! ${snapshot.error.toString()}");
          return Container(
            alignment: Alignment.center,
            height: double.maxFinite,
            child: const Text(
              "Mande Uma Mensagem\n 😉",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
              ),
            ),
          );
        }
        if (snapshot.hasData) {
          List<Message> messages = snapshot.data as List<Message>;
          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (ctx, i) => Align(
              alignment: Alignment.centerRight,
              child: CrudCard(
                text: messages[i].text,
                time: messages[i].time,
                id: messages[i].id,
                deleteMessage: deleteMessage,
                updateMessage: updateMessage,
              ),
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
    ;
  }
}
