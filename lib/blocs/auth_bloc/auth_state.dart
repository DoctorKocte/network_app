import 'package:network_app/models/token_model.dart';

sealed class AuthState {
  const AuthState();
}

class AuthLoadingState extends AuthState {}

class AuthAuthorizedState extends AuthState {
  TokenModel tokenModel;
  AuthAuthorizedState({required this.tokenModel});
}

class AuthErrorState extends AuthState {
  String errorString;
  AuthErrorState({required this.errorString});
}