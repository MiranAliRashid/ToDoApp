class Todo {
  String? title;
  String? content;
  DateTime? dueDate;
  DateTime? submitDate;

  Todo({this.title, this.content, this.dueDate, this.submitDate});

  factory Todo.fromMap(Map<String, dynamic> json) => Todo(
        title: json["title"],
        content: json["content"],
        dueDate: DateTime.parse(json["dueDate"]),
        submitDate: DateTime.parse(json["submitDate"]),
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "content": content,
        "dueDate": dueDate.toString(),
        "submitDate": submitDate.toString(),
      };
}
