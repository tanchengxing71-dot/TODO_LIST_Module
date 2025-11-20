import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_module/pages/login/user_login_state.dart';

class UserLoginCubit extends Cubit<UserLoginState>{
  UserLoginCubit(super.initialState){
    emit(Initial());
  }

  Future<void> login(String username, String password) async {
    emit(Loading());

    await Future.delayed(Duration(seconds: 1)); // 模拟网络请求

    if (username == 'admin' && password == '123') {
      emit(Success(username));
    } else {
      emit(Failure("账号或密码错误"));
    }
  }

}