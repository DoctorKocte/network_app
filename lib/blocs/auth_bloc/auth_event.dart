abstract class AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  String username;
  String password;

  AuthLoginEvent({required this.username, required this.password});
}