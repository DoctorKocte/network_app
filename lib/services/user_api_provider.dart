import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:network_app/DTO/token_dto.dart';
import 'package:network_app/DTO/users_dto.dart';
import 'package:network_app/models/token_model.dart';
import 'package:network_app/models/users_model.dart';
import 'package:network_app/services/api_response_model.dart';
import 'package:network_app/services/endpoint_config.dart';

class UserProvider {
  EndpointConfig endpointConfig = EndpointConfig();

  Future<Either<String, Users>> getUsers() async {
    final response = await http.get(Uri.parse(endpointConfig.getUsersEndpoint));
    log('${endpointConfig.getUsersEndpoint} ====> ${response.body}');

    final usersData = ApiResponse.parseBody(json.decode(response.body));
    if (usersData.success) {
      if (usersData.data != null) {
        final usersDTO = UsersDTO.fromJson(usersData.data!);
        final usersList = Users.fromDTO(usersDTO);
        return Right(usersList);
      } else {
        return Right(Users(users: []));
      }
    } else {
      return Left(usersData.message ?? 'Error fetching users');
    } 
  }

  Future<Either<String, TokenModel>> login({required String username, required String password}) async {
    log('login pressed');
    final response = await http.post(
      Uri.parse(endpointConfig.loginEndpoint),
      body: {'username': username, 'password': password}
    );
    log('${endpointConfig.loginEndpoint} ====> ${response.body}');
    final tokenData = ApiResponse.parseBody(json.decode(response.body));

    if (tokenData.success) {
      if (tokenData.data != null) {
        final tokenDTO = TokenDTO.fromJson(tokenData.data!);
        final tokenModel = TokenModel.fromDTO(dto: tokenDTO);
        return Right(tokenModel);
      } else {
        return const Left('Error login');
      }
    } else {
      return Left(tokenData.message ?? 'Error login: success: false');
    }
  }
}
