class ToDo {
  final String text;
  final String dueDate;
  String id = "no id";

  ToDo({
    required this.text,
    required this.dueDate,
  });

  factory ToDo.fromJSON(Map<String, dynamic> data) {
    return ToDo(
      text: data["text"],
      dueDate: data["due_date"],
    );
  }

  String showToDo() {
    return '''
    $id {
      Text: $text
      Time: $dueDate
    }
    ''';
  }
}
