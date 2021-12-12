import 'package:flutter/material.dart';
import 'package:flutter_firebase/controller/todo_controller.dart';
import 'package:flutter_firebase/model/todo.dart';
import 'package:flutter_firebase/widgets/create_todo.dart';
import 'package:flutter_firebase/widgets/todo_card.dart';
import 'package:flutter_firebase/widgets/update_todo.dart';

class ToDoPage extends StatefulWidget {
  ToDoPage({Key? key}) : super(key: key);

  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  var toDoData = ToDoController.read();

  updateData() => setState(() {
        toDoData = ToDoController.read();
      });

  deleteToDo(String id) async {
    await ToDoController.delete(id);
    updateData();
  }

  createToDo(String text, String dueDate) async {
    await ToDoController.create(text, dueDate);
    updateData();
  }

  updateToDo(String id, String dueDate) async {
    await ToDoController.update(id, dueDate);
    updateData();
  }

  showCreateDialog() => showDialog(
      context: context,
      builder: (context) => CreateToDo(createToDo: createToDo));

  showUpdateDialog(String id, String dueDate) => showDialog(
      context: context,
      builder: (context) => UpdateToDo(
            updateToDo: updateToDo,
            dueDate: dueDate,
            id: id,
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Tarefas"),
        actions: [
          IconButton(
            onPressed: showCreateDialog,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: toDoData,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("You have a error! ${snapshot.error.toString()}");
              return Container(
                alignment: Alignment.center,
                height: double.maxFinite,
                child: const Text(
                  "Adicione uma Tarefa\n 😉",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                ),
              );
            }
            if (snapshot.hasData) {
              List<ToDo> toDoList = snapshot.data as List<ToDo>;
              return ListView.builder(
                itemCount: toDoList.length,
                itemBuilder: (ctx, i) => ToDoCard(
                  toDo: toDoList[i],
                  deleteToDo: deleteToDo,
                  updateToDo: showUpdateDialog,
                ),
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
