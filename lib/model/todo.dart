import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo {
  int? id;
  String? title;
  String? content;
  String? time;
  int? type;
  int? status;

  Todo({
    this.id,
    this.title,
    this.content,
    this.time,
    this.type,
    this.status
  });

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
  Map<String, dynamic> toJson() => _$TodoToJson(this);

  Todo copyWith({
    int? id,
    String? title,
    String? content,
    String? time,
    int? type,
    int? status,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      time: time ?? this.time,
      type: type ?? this.type,
      status: status ?? this.status,
    );
  }
}