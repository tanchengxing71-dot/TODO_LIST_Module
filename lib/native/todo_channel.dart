import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:todo_list_module/model/todo.dart';



class TodoChannel {
  static final MethodChannel _channel = const MethodChannel("Tcx.todo");

  static const String insertTodo= "insert_todo";
  static const String deleteTodo = "delete_todo";
  static const String queryAllTodo = "query_todo";
  static const String queryTodoByType = "query_todo_by_type";
  static const String updateTodo = "update_todo";


  static Future<int?> insert(Todo todo) async{
    int? id = await _channel.invokeMethod(insertTodo, todo.toJson());
    return id;
  }

  static Future<int?> delete(Todo todo) async{
    int? id = await _channel.invokeMethod(deleteTodo, todo.toJson());
    return id;
  }

  static Future<int?> update(Todo todo) async{
    int? id = await _channel.invokeMethod(updateTodo, todo.toJson());
    return id;
  }

  static Future<List<Todo>> queryAll() async{
    final String? jsonString = await _channel.invokeMethod(queryAllTodo);

    if (jsonString == null || jsonString.isEmpty) return [];
    // 解析 JSON 字符串
    final List<dynamic> jsonList = json.decode(jsonString);
    // 转成 List<Todo>
    final List<Todo> todos = jsonList.map((e) => Todo.fromJson(e)).toList();

    return todos;
  }

  static Future<List<Todo>> queryByType(int type) async{
    final String? jsonString = await _channel.invokeMethod(queryTodoByType, {
      "type": type
    });
    if (jsonString == null || jsonString.isEmpty) return [];
    // 解析 JSON 字符串
    final List<dynamic> jsonList = json.decode(jsonString);
    // 转成 List<Todo>
    final List<Todo> todos = jsonList.map((e) => Todo.fromJson(e)).toList();
    return todos;
  }


}