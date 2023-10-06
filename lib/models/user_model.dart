import 'dart:developer';

import 'package:network_app/services/user_api_provider.dart';

class UserDTO {
  String id;
  String username;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? imageString;

  UserDTO({
    required this.id, 
    required this.username,
    this.firstName, 
    this.lastName, 
    this.phoneNumber,
    this.imageString
  });
}

class User {
  String id;
  String firstName;
  String lastName;
  String? phoneNumber;
  String? imageString;

  User({
    required this.id, 
    required this.firstName, 
    required this.lastName, 
    this.phoneNumber,
    this.imageString
  });

  factory User.fromJson(Map<String, dynamic> json) {
    log('USER MODEL: ${json}');
    return User(
      id: json['_id'],
      firstName: json['firstName'] ?? json['username'],
      lastName: json['lastName'] ?? '',
      phoneNumber: json['phoneNumber'],
      imageString: json['imageString']
    );
  }

  factory User.fromDTO({required UserDTO dto}) {
    return User(
        id: dto.id,
        firstName: dto.firstName ?? dto.username,
        lastName: dto.lastName ?? '',
        phoneNumber: dto.phoneNumber,
        imageString: dto.imageString
    );
  }
}