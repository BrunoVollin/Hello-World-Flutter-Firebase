import 'dart:convert';
import 'package:flutter_firebase/model/todo.dart';
import 'package:http/http.dart' as http;

class ToDoController {
  static get _baseUrl =>
      "https://projeto-flutter-68b0c-default-rtdb.firebaseio.com/";

  static create(String text, String dueDate) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/todo_list.json"),
      body: json.encode({
        'text': text,
        'due_date': dueDate,
      }),
    );

    if (response.statusCode == 200) {
      var result = json.decode(response.body)["name"];
      return result;
    } else {
      throw Exception('Failed to create ToDo');
    }
  }

  static read() async {
    final response = await http.get(
      Uri.parse("$_baseUrl/todo_list.json"),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = json.decode(response.body);
      final messagesList = <ToDo>[];

      responseMap.forEach((key, value) {
        final newToDo = ToDo.fromJSON(value);
        newToDo.id = key;
        messagesList.add(newToDo);
      });
      return messagesList;
    } else {
      throw Exception('Failed to read ToDo');
    }
  }

  static update(String id, String dueDate) async {
    final response = await http.patch(
      Uri.parse("$_baseUrl/todo_list/$id.json"),
      body: jsonEncode({'due_date': dueDate}),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to update ToDo');
    }
  }

  static delete(String id) async {
    final response = await http.delete(
      Uri.parse("$_baseUrl/todo_list/$id.json"),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to delete ToDo');
    }
  }
}

printToDos() async {
  List<ToDo> toDos = await ToDoController.read();

  for (var toDo in toDos) {
    print(toDo.showToDo());
  }
}

main() async {
  // /ToDo message = await ToDoController.readById("-Mpq6lS9TOdYaUzsX5mQ");

  // print(message.showToDo());

  // //* Create
  // var id = await ToDoController.create("Jogar fifa", "10/12/2021");

  // //* Read

  // //* Delete
  // await ToDoController.delete("-MqZBUtUG1enGW6889Q0");
  printToDos();

  // //* Read
  // print("Depois d0 delete:");
  // printToDos();
}
