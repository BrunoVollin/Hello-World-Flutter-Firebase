import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/controller/message_controller.dart';
import 'package:flutter_firebase/model/message.dart';
import 'package:flutter_firebase/widgets/crud_card.dart';
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

  chatTextBox() => Row(
        children: [
          Expanded(
            flex: 10,
            child: TextField(
              controller: controllerText,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              onChanged: (text) {
                messageText = text;
              },
              decoration: InputDecoration(
                hintText: "Escreva sua mensagem...",
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    controllerText.clear();
                    updateTime();
                    await MessageController.create(messageText, time);
                    messageText = "";
                    reloadMessages();
                  },
                ),
              ),
            ),
          ),
        ],
      );

  listMessages() {
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
              child: listMessages(),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: chatTextBox(),
            )
          ],
        ),
      ),
    );
  }
}
