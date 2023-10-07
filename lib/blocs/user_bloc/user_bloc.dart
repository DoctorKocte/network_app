import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_app/services/user_repository.dart';
import 'package:network_app/blocs/user_bloc/user_event.dart';
import 'package:network_app/blocs/user_bloc/user_state.dart';

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
        final result = await usersRepository.getAllUsers();

        result.fold(
          (l) => emit(UserErrorState()),
          (r) => emit(UserDataState(usersData: r))
        );
            // if (r.users.isEmpty) {
            //   emit(UserEmptyState());
            // } else {
            //   emit(UserDataState(usersData: r));
            // }
      } catch (e) {
        emit(UserErrorState());
      }
    }
  }
}
