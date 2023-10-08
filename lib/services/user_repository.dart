import 'package:dartz/dartz.dart';
import 'package:network_app/models/token_model.dart';
import 'package:network_app/models/users_model.dart';
import 'package:network_app/services/user_api_provider.dart';

class UserRepository {
  final UserProvider _userProvider = UserProvider();

  Future<Either<String, Users>> getAllUsers() => _userProvider.getUsers();

  Future<Either<String, TokenModel>> login({required String username, required String password}) {
    return _userProvider.login(username: username, password: password);
  }
}
