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
  var carregado = false;
  String messageText = "";
  String newMessageText = "";
  String time = DateFormat("HH:mm").format(DateTime.now());
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  var messageData = MessageController.read();
  var controller = TextEditingController();

  chatTextBox() => Row(
        children: [
          Expanded(
            flex: 10,
            child: TextField(
              controller: controller,
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
                    controller.clear();
                    await MessageController.create(messageText, time);
                    setState(() {
                      messageData = MessageController.read();
                    });
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
        return CircularProgressIndicator();
      },
    );
  }

  submit() => Navigator.of(context).pop();

  deleteMessage(String id) async {
    await MessageController.delete(id);
    setState(() {
      messageData = MessageController.read();
    });
  }

  updateMessage(String id) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Editar Mensagem"),
          content: TextField(
            onChanged: (text) {
              newMessageText = text;
            },
            decoration:
                const InputDecoration(hintText: "Entre com a nova mensagem"),
          ),
          actions: [
            TextButton(
              child: const Text("Enviar"),
              onPressed: () {
                MessageController.update(newMessageText, id);
                setState(() {
                  messageData = MessageController.read();
                });
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
