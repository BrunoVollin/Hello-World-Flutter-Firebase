import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/model/message.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Crud Firebase")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(""),
        ),

        // textBottom(),
      ),
    );
  }
}
