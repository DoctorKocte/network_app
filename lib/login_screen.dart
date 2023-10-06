import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_app/auth_bloc/auth_bloc.dart';
import 'package:network_app/auth_bloc/auth_event.dart';
import 'package:network_app/auth_bloc/auth_state.dart';
import 'package:network_app/home_page.dart';
import 'package:network_app/services/user_repository.dart';
import 'package:network_app/widgets/login_button.dart';
import 'package:network_app/widgets/text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final usersRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    String username = "";
    String password = "";

    return BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(usersRepository: usersRepository),
        child: Scaffold(
            appBar: AppBar(
                title: Text('Login'),
                centerTitle: true,
                backgroundColor: Colors.transparent),
            backgroundColor: const Color.fromARGB(255, 216, 228, 229),
            body: // SingleChildScrollView(
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 28),
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
                         onChanged:(value) {
                          password = value;
                        },
                      ),
                      Spacer(),
                      LoginView(),
                      Builder(builder: (context) {
                        return LoginButton(
                          buttonText: 'Login',
                          isOutlined: true,
                          onPressed: () {
                            final AuthBloc _authBloc = BlocProvider.of(context);
                            _authBloc.add(AuthLoginEvent(username: username, password: password));
                          },
                        );
                      })
                    ]))));
  }
}

class LoginView extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthorizedState) {
            print(state.tokenModel.accessToken);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MyHomePage()));
          } else if (state is AuthLoadingState) {
            //Builder(builder: (context) { return
             Center(child: CircularProgressIndicator());
            //});
          } else if (state is AuthErrorState) {
          showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Center(child: Text('Error')),
                content: Text(state.errorString),
                 actions: [TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })]
          ));
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(state.errorString),
            //   ),
            // );
          }
        },
        child: Spacer());
  }
}

                        //       AuthLoadingState() => CircularProgressIndicator(),
                        //       AuthAuthorizedState() => MyHomePage(),
                        //       AuthUnauthorizedState() => Container(),
                        //       AuthErrorState() => Center(child: Text('error'),)