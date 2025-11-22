// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  content: json['content'] as String?,
  time: json['time'] as String?,
  type: (json['type'] as num?)?.toInt(),
);

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'content': instance.content,
  'time': instance.time,
  'type': instance.type,
};
