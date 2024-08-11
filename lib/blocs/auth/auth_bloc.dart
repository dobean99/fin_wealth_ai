import 'package:fin_wealth/respositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final success = await authRepository.authenticate(
        event.username,
        event.password,
      );
      if (success) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure('Authentication failed'));
      }
    } catch (error) {
      emit(AuthFailure(error.toString()));
    }
  }
}
