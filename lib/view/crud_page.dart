import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/controller/message_controller.dart';
import 'package:flutter_firebase/model/message.dart';
import 'package:flutter_firebase/widgets/chat_text_box.dart';
import 'package:flutter_firebase/widgets/crud_card.dart';
import 'package:flutter_firebase/widgets/message_list.dart';
import 'package:intl/intl.dart';

class CrudPage extends StatefulWidget {
  CrudPage({Key? key}) : super(key: key);

  @override
  _CrudPageState createState() => _CrudPageState();
}

class _CrudPageState extends State<CrudPage> {
  String messageText = "";
  String time = DateFormat("HH:mm").format(DateTime.now());
  var messageData = MessageController.read();
  var controllerText = TextEditingController();

  updateTime() => time = DateFormat("HH:mm").format(DateTime.now());

  reloadMessages() => setState(() {
        messageData = MessageController.read();
      });

  Future onSendMessage() async {
    controllerText.clear();
    updateTime();
    if (messageText.isEmpty) return;
    await MessageController.create(messageText, time);
    messageText = "";
    reloadMessages();
  }

  onChange(String text) {
    messageText = text;
  }

  submit() => Navigator.of(context).pop();

  deleteMessage(String id) async {
    await MessageController.delete(id);
    reloadMessages();
  }

  updateMessage(String id) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Editar Mensagem"),
          content: TextField(
            onChanged: (text) {
              messageText = text;
            },
            decoration:
                const InputDecoration(hintText: "Entre com a nova mensagem"),
          ),
          actions: [
            TextButton(
              child: const Text("Enviar"),
              onPressed: () {
                MessageController.update(messageText, id);
                reloadMessages();
                submit();
              },
            ),
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () {
                submit();
              },
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Crud Firebase")),
      body: Center(
        child: Column(
          children: [
            Flexible(
              child: MessageList(
                updateMessage: (id) {
                  updateMessage(id);
                },
                deleteMessage: (id) {
                  deleteMessage(id);
                },
                messageData: messageData,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ChatTextBox(
                controllerText: controllerText,
                onChange: onChange,
                onPressed: () {
                  onSendMessage();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
