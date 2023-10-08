import 'dart:developer';

class TokenDTO {
  TokenDTO({required this.accessToken, required this.refreshToken});

  factory TokenDTO.fromJson(Map<String, dynamic> json) {
    log('TOKEN MODEL: $json');
    return TokenDTO(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken']
    );
  }

  String accessToken;
  String refreshToken;
}
