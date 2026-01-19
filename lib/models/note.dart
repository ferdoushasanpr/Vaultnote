import 'package:uuid/uuid.dart';

class Note {
  final String id;
  final String title;
  final String location;
  final String content;
  final DateTime createdAt;

  Note({
    String? id,
    required this.title,
    required this.location,
    required this.content,
    required this.createdAt,
  }) : id = id ?? const Uuid().v4();

  // Convert Note to JSON map
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'location': location,
    'content': content,
    'createdAt': createdAt.toIso8601String(),
  };

  // Create Note from JSON map
  factory Note.fromJson(Map<String, dynamic> json) => Note(
    id: json['id'],
    title: json['title'],
    location: json['location'],
    content: json['content'],
    createdAt: DateTime.parse(json['createdAt']),
  );
}
