import 'package:network_app/DTO/users_dto.dart';
import 'package:network_app/models/user_model.dart';

class Users {
  Users({required this.users});

  factory Users.fromDTO(UsersDTO dto) {
    return Users(
      users: dto.users.map((userDTO) => User.fromDTO(dto: userDTO)).toList()
    );
  }

  List<User> users;
}
