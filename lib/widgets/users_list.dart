import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_app/user_bloc/user_bloc.dart';
import 'package:network_app/user_bloc/user_state.dart';

class UsersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return switch (state) {
          UserEmptyState() => const Center(child: Text('List is empty.')),
          UserLoadingState() => const Center(child: CircularProgressIndicator()),
          UserErrorState() => const Center(child: Text('Something went wrong!')),
          UserDataState() => Padding(
            padding: const EdgeInsets.all(6),
            child: ListView.builder(
              itemCount: state.userData.length,
              itemBuilder: (context, index) => 
                 Card(
                    child: ListTile(
                      leading: (state.userData[index].imageString != null) 
                        ? Image.memory(base64Decode(state.userData[index].imageString!))
                        : const Icon(Icons.perm_media_sharp),
                      title: Text('${state.userData[index].firstName} ${state.userData[index].lastName}'),
                      subtitle: Text('phone number: ${state.userData[index].phoneNumber ?? 'empty'}'),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20,
                      ),
                    )),
                  ))
        };
      },
    );
  }
}