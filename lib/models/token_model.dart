import 'package:network_app/DTO/token_dto.dart';

class TokenModel {
  TokenModel({required this.accessToken, required this.refreshToken});

  factory TokenModel.fromDTO({required TokenDTO dto}) {
    return TokenModel(
      accessToken: dto.accessToken,
      refreshToken: dto.refreshToken
    );
  }

  String accessToken;
  String refreshToken;
}
