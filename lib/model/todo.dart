class ToDo {
  final String text;
  final String dueDate;
  String id = "no id";

// ignore: slash_for_doc_comments
/**
* + text: String
 * + dueDate: String
 * + id: String 
 */

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