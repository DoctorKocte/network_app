import 'package:network_app/models/token_model.dart';
import 'package:network_app/models/user_model.dart';
import 'package:network_app/services/user_api_provider.dart';

class UserRepository {
  final UserProvider _userProvider = UserProvider();

  Future<List<User>> getAllUsers() => _userProvider.getUsers();

  Future<TokenModel> login({required String username, required String password}) {
    return _userProvider.login(username: username, password: password);
  }
}