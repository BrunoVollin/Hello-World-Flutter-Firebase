import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/widgets/crud_card.dart';
import 'package:intl/intl.dart';

class CrudPage extends StatefulWidget {
  CrudPage({Key? key}) : super(key: key);

  @override
  _CrudPageState createState() => _CrudPageState();
}

class _CrudPageState extends State<CrudPage> {
  var messages;
  var carregado = false;
  String messageText = "";
  String time = DateFormat("HH:mm").format(DateTime.now());
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  sendMessage() async {
    setState(() {
      messageText;
      time = DateFormat("HH:mm").format(DateTime.now());
    });
    DatabaseReference _testRef =
        FirebaseDatabase.instance.reference().child("messages");
    _testRef.push().set({"text": messageText, "time": time});

    await _testRef.onValue.listen((event) {
      messages = Map<String, dynamic>.from(event.snapshot.value);
      setState(() {
        messages;
      });
      print("---------------------------------");
      print(messages);
    });
  }

  textBottom() => Row(
        children: [
          Expanded(
            flex: 10,
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              onChanged: (text) {
                messageText = text;
              },
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            color: Colors.blue,
            icon: Icon(Icons.send),
            onPressed: sendMessage,
          ),
        ],
      );

  getMessages(snapshot) async {
    final tilesList = <CrudCard>[];
    if (snapshot.hasData) {
      final myMessages =
          Map<String, dynamic>.from((snapshot.data! as Event).snapshot.value);
      myMessages.forEach(
        (key, value) {
          final nextMessage = Map<String, dynamic>.from(value);
          final messageTile = CrudCard(
            time: nextMessage["time"],
            text: nextMessage["text"],
          );
          print("* messageTile: $messageTile");
          return tilesList.add(messageTile);
        },
      );
    }
  }

  messagesList() async {
    DatabaseReference _testRef =
        FirebaseDatabase.instance.reference().child("messages");
    return StreamBuilder(
      stream: _testRef.child("messages").orderByKey().limitToLast(10).onValue,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("You have a error! ${snapshot.error.toString()}");
          return const Text("Error :(");
        }
        if (snapshot.hasData) {
          // var tilesList = getMessages(snapshot);
          final tilesList = <CrudCard>[];
          if (snapshot.hasData) {
            final myMessages = Map<String, dynamic>.from(
                (snapshot.data! as Event).snapshot.value);
            myMessages.forEach(
              (key, value) {
                final nextMessage = Map<String, dynamic>.from(value);
                final messageTile = CrudCard(
                  time: nextMessage["time"],
                  text: nextMessage["text"],
                );
                print("* messageTile: $messageTile");
                tilesList.add(messageTile);
              },
            );
          }
          return Expanded(
            child: ListView(
              children: tilesList,
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  a() async {
    var b = await messagesList();
    return b;
  }

  DatabaseReference _testRef =
      FirebaseDatabase.instance.reference().child("messages");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Crud Firebase")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  // children: [CrudCard(time: time, text: messageText), textBottom()],
                  children: [
                    StreamBuilder(
                      stream: _testRef
                          .orderByKey()
                          .limitToLast(10)
                          .onValue,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          print(
                              "You have a error! ${snapshot.error.toString()}");
                          return const Text("Error :(");
                        }
                        if (snapshot.hasData) {
                          // var tilesList = getMessages(snapshot);
                          final tilesList = <CrudCard>[];
                          if (snapshot.hasData) {
                            final myMessages = Map<String, dynamic>.from(
                                (snapshot.data! as Event).snapshot.value);
                            myMessages.forEach(
                              (key, value) {
                                final nextMessage =
                                    Map<String, dynamic>.from(value);
                                final messageTile = CrudCard(
                                  time: nextMessage["time"],
                                  text: nextMessage["text"],
                                );
                                tilesList.add(messageTile);
                              },
                            );
                          }
                         
                          return Expanded(
                            child: ListView(
                              children: tilesList,
                            ),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                    textBottom(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
