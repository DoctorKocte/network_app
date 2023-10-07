import 'dart:developer';

class TokenDTO {
  String accessToken;
  String refreshToken;

  TokenDTO({required this.accessToken, required this.refreshToken});

  factory TokenDTO.fromJson(Map<String, dynamic> json) {
    log('TOKEN MODEL: $json');
    return TokenDTO(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken']
    );
  }
}