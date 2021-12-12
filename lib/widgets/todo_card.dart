import 'package:flutter/material.dart';
import 'package:flutter_firebase/model/todo.dart';

class ToDoCard extends StatelessWidget {
  const ToDoCard({
    Key? key,
    required this.toDo,
    required this.deleteToDo,
    required this.updateToDo,
  }) : super(key: key);

  final ToDo toDo;
  final Function deleteToDo;
  final Function updateToDo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(toDo.text,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Data Limite: ${toDo.dueDate}",
                      style: TextStyle(color: Colors.black45)),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      updateToDo(toDo.id, toDo.dueDate);
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.orange,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      deleteToDo(toDo.id);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
