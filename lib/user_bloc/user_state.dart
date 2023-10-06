import 'package:network_app/models/user_model.dart';

sealed class UserState {
  const UserState();
}

class UserEmptyState extends UserState {}

class UserLoadingState extends UserState {}

class UserDataState extends UserState {
  List<User> userData;
  UserDataState({required this.userData});
}

class UserErrorState extends UserState {}