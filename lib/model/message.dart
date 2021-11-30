class Message {
  final String text;
  final String time;

  Message({
    required this.text,
    required this.time,
  });

  factory Message.fromRTDB(Map<String, dynamic> data) {
    return Message(
      text: data["text"],
      time: data["time"],
    );
  }
}
