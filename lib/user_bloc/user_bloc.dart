import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_app/services/user_repository.dart';
import 'package:network_app/user_bloc/user_event.dart';
import 'package:network_app/user_bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository usersRepository;

  UserBloc({required this.usersRepository}) : super(UserEmptyState()) {
    on<UserEvent>(_onStarted);
  }

  Future<void> _onStarted(
    UserEvent event,
    Emitter<UserState> emit,
  ) async {
    if (event is UserClearEvent) {
      emit(UserEmptyState());
    } else {
      emit(UserLoadingState());
      try {
        final users = await usersRepository.getAllUsers();
        if (users.isEmpty) {
          emit(UserEmptyState());
        } else {
          emit(UserDataState(userData: users));
        }
      } catch (e) {
        emit(UserErrorState());
      }
    }
  }
}
