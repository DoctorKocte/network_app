import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_app/features/users/user_bloc/user_bloc.dart';
import 'package:network_app/features/users/user_bloc/user_event.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 136, 22, 207));

    final UserBloc userBloc = BlocProvider.of(context);

    return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
          children: [
            ElevatedButton(
              style: style,
              onPressed: () {
                userBloc.add(UserLoadEvent());
              },
              child: const Text('Load'),
            ),
            ElevatedButton(
              style: style,
              onPressed: () {
                userBloc.add(UserClearEvent());
              },
              child: const Text('Clear'),
            ),
          ]
        )
    );
  }
}
