import 'dart:convert';


class Task {
  int? id;
  String? title;
  String? description;

  Task({
    this.id,
    this.title,
    this.description,
  });

  // Moved from TaskFromJson extension
  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json['id'] as int,
    title: json['title'] as String,
    description: json['description'] as String,
  );

  factory Task.fromMap(Map<String, dynamic> map) => Task(
    id: map['id'] as int,
    title: map['title'] as String,
    description: map['description'] as String,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'description': description,
  };
}
