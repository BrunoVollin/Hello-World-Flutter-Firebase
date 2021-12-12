import 'package:flutter/material.dart';

class CreateToDo extends StatelessWidget {
  CreateToDo({
    Key? key,
    required this.createToDo,
  }) : super(key: key);

  var textToDo = "";
  var textDueDate = "";

  final Function createToDo;


  onChangedText(text) => textToDo = text;
  onChangedDueDate(text) => textDueDate = text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Editar Mensagem"),
      content: Container(
        constraints: const BoxConstraints(maxHeight: 100),
        child: Column(
          children: [
            TextField(
              onChanged: (text) => onChangedText(text),
              decoration: const InputDecoration(
                  hintText: "Entre com o texto da tarefa..."),
            ),
            TextField(
              onChanged: (text) => onChangedDueDate(text),
              decoration: const InputDecoration(
                  hintText: "Entre com a data da tarefa..."),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text("Criar"),
          onPressed: () {
            createToDo(textToDo, textDueDate);
            Navigator.of(context).pop();
          },
        ),
        TextButton(child: const Text("Cancelar"), onPressed: () {
          Navigator.of(context).pop();
        }),
      ],
    );
  }
}
