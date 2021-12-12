import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase/view/todo_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("You have a error! ${snapshot.error.toString()}");
            return const Text("Error :(");
          }
          if (snapshot.hasData) {
            print(Firebase.apps);
            return ToDoPage();
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
