class Message {
  final String text;
  final String time;
  String id = "no id";

  Message({
    required this.text,
    required this.time,
  });

  factory Message.fromJSON(Map<String, dynamic> data) {
    return Message(
      text: data["text"],
      time: data["time"],
    );
  }

  String showMessage() {
    return '''
    $id {
      Text: ${text}
      Time: ${time} 
    }
    ''';
  }
}
