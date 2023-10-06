import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:network_app/models/token_model.dart';
import 'package:network_app/models/user_model.dart';
import 'package:network_app/services/endpoint_config.dart';

class UserProvider {
  EndpointConfig endpointConfig = EndpointConfig();

  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse(endpointConfig.getUsersEndpoint));
    log('${endpointConfig.getUsersEndpoint} ====> ${response.body}');

    if (response.statusCode == 200) {
      List<User> usersList = [];
      final Map<String, dynamic> userJson = json.decode(response.body);
      final data = userJson['data'];
      final users = data['users'];
      users.forEach((user) => usersList.add((User.fromJson(user) as User)));
      return usersList;
    } else {
      throw Exception('Error fetching users');
    }
  }

  Future<TokenModel> login({required String username, required String password}) async {
    final response = await http.post(
      Uri.parse(endpointConfig.loginEndpoint),
      body: {"username": username, "password": password}
    );
    log('${endpointConfig.loginEndpoint} ====> ${response.body}');

    final Map<String, dynamic> userJson = json.decode(response.body);
    if (userJson['data'] != null) {
      final data = userJson['data'];
      return TokenModel.fromJson(data);
    } else if (userJson['message'] != null) {
      throw Exception(userJson['message']);
    } else {
      throw Exception('Error login');
    }
  }
}