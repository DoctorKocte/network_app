import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_app/blocs/user_bloc/user_bloc.dart';
import 'package:network_app/services/user_repository.dart';
import 'package:network_app/widgets/action_buttons.dart';
import 'package:network_app/widgets/users_list.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final usersRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (context) => UserBloc(usersRepository: usersRepository),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 216, 228, 229),
        appBar: AppBar(
          title: const Text('Users'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          //automaticallyImplyLeading: false
        ),
        body: const Column(
          children: [
            ActionButtons(),
            Expanded(
              child: UsersList()
            )
        ]),
      ),
    );
  }
}
