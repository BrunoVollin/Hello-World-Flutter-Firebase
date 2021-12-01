import 'dart:convert';
import 'package:flutter_firebase/model/message.dart';
import 'package:http/http.dart' as http;

class MessageController {
  static get _baseUrl =>
      "https://projeto-flutter-68b0c-default-rtdb.firebaseio.com/";

  static create(String text, String time) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/message.json"),
      body: json.encode({
        'text': text,
        'time': time,
      }),
    );

    if (response.statusCode == 200) {
      var result = json.decode(response.body)["name"];
      return result;
    } else {
      throw Exception('Failed to create Message');
    }
  }

  static readById(String id) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/message/$id.json"),
    );

    if (response.statusCode == 200) {
      Message message = Message.fromJSON(json.decode(response.body));
      message.id = id;
      return message;
    } else {
      throw Exception('Failed to read Message');
    }
  }

  static read() async {
    final response = await http.get(
      Uri.parse("$_baseUrl/message.json"),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = json.decode(response.body);
      final messagesList = <Message>[];

      responseMap.forEach((key, value) {
        final newMessage = Message.fromJSON(value);
        newMessage.id = key;
        messagesList.add(newMessage);
      });
      return messagesList;
    } else {
      throw Exception('Failed to read Message');
    }
  }

  static update(String text, String id) async {
    final response = await http.patch(
      Uri.parse("$_baseUrl/message/$id.json"),
      body: jsonEncode({'text': text}),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to update Message');
    }
  }

  static delete(String id) async {
    final response = await http.delete(
      Uri.parse("$_baseUrl/message/$id.json"),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to delete Message');
    }
  }
}

printMessages() async {
  List<Message> messages = await MessageController.read();

  for (var msg in messages) {
    print(msg.showMessage());
  }
}

main() async {
  // Message message = await MessageController.readById("-Mpq6lS9TOdYaUzsX5mQ");

  // print(message.showMessage());

  // //* Create
  // var id = await MessageController.create("Mensagem para deletar.", "13:00");

  // //* Read
  // print("Antes do delete:");
  printMessages();

  // //* Delete
  // await MessageController.delete(id);

  // //* Read
  // print("Depois d0 delete:");
  // printMessages();
}
