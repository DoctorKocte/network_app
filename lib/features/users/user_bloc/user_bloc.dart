import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_app/features/users/user_bloc/user_event.dart';
import 'package:network_app/features/users/user_bloc/user_state.dart';
import 'package:network_app/services/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required this.usersRepository}) : super(UserLoadingState()) {
    on<UserEvent>(_onStarted);
    add(UserLoadEvent());
  }

  final UserRepository usersRepository;

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
      } catch (e) {
        emit(UserErrorState());
      }
    }
  }
}
