import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_app/auth_bloc/auth_event.dart';
import 'package:network_app/auth_bloc/auth_state.dart';
import 'package:network_app/services/user_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository usersRepository;

  AuthBloc({required this.usersRepository}) : super(AuthLoadingState()) {
    on<AuthEvent>(_login);
  }

  Future<void> _login(
    AuthEvent event,
    Emitter<AuthState> emit,
  ) async {
      if (event is AuthLoginEvent) {
        emit(AuthLoadingState());
        final result = await usersRepository.login(username: event.username, password: event.password);

        result.fold(
          (l) => emit(AuthErrorState(errorString: l)),
          (r) => emit(AuthAuthorizedState(tokenModel: r)),
        );
    }
  }
}
