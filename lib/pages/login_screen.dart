import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:network_app/blocs/auth_bloc/auth_event.dart';
import 'package:network_app/blocs/auth_bloc/auth_state.dart';
import 'package:network_app/pages/home_page.dart';
import 'package:network_app/services/user_repository.dart';
import 'package:network_app/widgets/login_button.dart';
import 'package:network_app/widgets/text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final usersRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    var username = '';
    var password = '';

    return BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(usersRepository: usersRepository),
        child: Scaffold(
            appBar: AppBar(
                title: const Text('Login'),
                centerTitle: true,
                backgroundColor: Colors.transparent),
            backgroundColor: const Color.fromARGB(255, 216, 228, 229),
            body: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 28),
                child: Column(children: [
                  InputTextField(
                    textFieldTitle: 'Login',
                    //type: TextFieldType.username,
                    onChanged: (value) {
                      username = value;
                    },
                  ),
                  InputTextField(
                    textFieldTitle: 'Password',
                    //type: TextFieldType.password,
                    isObscureTextNeeded: true,
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  const Spacer(),
                  const LoginView(),
                  Builder(builder: (context) {
                    return LoginButton(
                      buttonText: 'Login',
                      isOutlined: true,
                      onPressed: () {
                        final AuthBloc authBloc = BlocProvider.of(context);
                        authBloc.add(AuthLoginEvent(username: username, password: password));
                      },
                    );
                  })
                ]))));
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthorizedState) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyHomePage()));
          } else if (state is AuthLoadingState) {
            // Не смогла разобраться, почему не отображается индикатор
            // Вероятно потому что это BlocListener, а не BlocBuilder
            // но в билдере не получается сделать открытие нового экрана

            //Builder(builder: (context) { return
            const Center(child: CircularProgressIndicator());
            //});
          } else if (state is AuthErrorState) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                        title: const Center(child: Text('Error')),
                        content: Text(state.errorString),
                        actions: [
                          TextButton(
                              child: const Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              })
                        ]));
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(state.errorString),
            //   ),
            // );
          }
        },
        child: const Spacer());
  }
}

   //       AuthLoadingState() => CircularProgressIndicator(),
   //       AuthAuthorizedState() => MyHomePage(), ???
   //       AuthUnauthorizedState() => Container(),
   //       AuthErrorState() => Center(child: Text('error'),)