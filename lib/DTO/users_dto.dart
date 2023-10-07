import 'package:network_app/DTO/user_dto.dart';

class UsersDTO {
  List<UserDTO> users;

  UsersDTO({required this.users});

   factory UsersDTO.fromJson(Map<String, dynamic> json) {
    // Не получилось через map, он никак не мог привестись к типу List<UserDTO>
    //var xxx = (json['users'].map((userDTO) => (UserDTO.fromJson(userDTO) as UserDTO)).toList() as List<UserDTO>);
    return UsersDTO(
      users: [for (var userDTO in json['users']) UserDTO.fromJson(userDTO)]
    );
   }
}