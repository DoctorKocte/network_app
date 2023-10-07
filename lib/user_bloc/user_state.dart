import 'package:network_app/models/users_model.dart';

sealed class UserState {
  const UserState();
}

class UserEmptyState extends UserState {}

class UserLoadingState extends UserState {}

class UserDataState extends UserState {
  Users usersData;
  UserDataState({required this.usersData});
}

class UserErrorState extends UserState {}