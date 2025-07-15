sealed class UserLoginState {}

class Initial extends UserLoginState {}

class Loading extends UserLoginState {}

class Success extends UserLoginState {
  final String successMessage;
  Success(this.successMessage);
}

class Failure extends UserLoginState {
  final String errorMessage;
  Failure(this.errorMessage);
}
