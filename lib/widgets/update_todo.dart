import 'package:flutter/material.dart';

class UpdateToDo extends StatelessWidget {
  UpdateToDo({
    Key? key,
    required this.id,
    required this.updateToDo,
    required this.dueDate,
  }) : super(key: key);

  var textText = "";
  var textDueDate = "";
  var id = "";

  final String dueDate;
  final Function updateToDo;

  onChangedDueDate(text) => textDueDate = text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Editar data da tarefa"),
      content: TextField(
        controller: TextEditingController()..text = dueDate,
        onChanged: (text) => onChangedDueDate(text),
        decoration:
            const InputDecoration(hintText: "Entre com a data da tarefa..."),
      ),
      actions: [
        TextButton(
          child: const Text("Criar"),
          onPressed: () {
            updateToDo(id, textDueDate);
            Navigator.of(context).pop();
          },
        ),
        TextButton(
            child: const Text("Cancelar"),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}
