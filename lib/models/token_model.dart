import 'dart:developer';

class TokenModel {
  String accessToken;
  String refreshToken;

  TokenModel({required this.accessToken, required this.refreshToken});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    log('TOKEN MODEL: ${json}');
    return TokenModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken']
    );
  }
}