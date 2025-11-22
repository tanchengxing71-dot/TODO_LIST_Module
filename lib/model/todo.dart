import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo {
  int? id;
  String? title;
  String? content;
  String? time;
  int? type;

  Todo({
    this.id,
    this.title,
    this.content,
    this.time,
    this.type,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
  Map<String, dynamic> toJson() => _$TodoToJson(this);
}