import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_module/model/todo.dart';
import 'package:todo_list_module/native/todo_channel.dart';
import 'package:todo_list_module/pages/login/user_login_state.dart';
import 'package:todo_list_module/pages/todo/todo_list_state.dart';

class TodoListCubit extends Cubit<TodoListState>{
  TodoListCubit() : super(TodoListState());

  Future<void> insertTodo(Todo todo) async{
    final id = await TodoChannel.insert(todo);
    if(id!=null && id>0){
      queryAll();
    }
  }

  Future<void> queryAll()async{
    final list = await TodoChannel.queryAll();
    emit(state.copyWith(list: list));
  }

  init(){
    queryAll();
  }

}