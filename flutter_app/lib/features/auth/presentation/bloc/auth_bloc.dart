import 'package:bloc/bloc.dart';
import 'package:flutter_app/features/auth/domain/usecases/login_use_case.dart';
import 'package:flutter_app/features/auth/domain/usecases/register_use_case.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final _storage = const FlutterSecureStorage();

  AuthBloc({required this.registerUseCase, required this.loginUseCase}) : super(AuthInitial()) {
    on<RegisterEvent>(_onRegister);
    on<LoginEvent>(_onLogin);
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
       await registerUseCase(event.username, event.email, event.password);
      emit(AuthSuccess(message: "Registration successful"));
    } catch (e) {
      emit(AuthFailure(error: "Registration failed"));
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase(event.email, event.password);
      await _storage.write(key: 'token', value: user.token);
      emit(AuthSuccess(message: "Login successful"));
    } catch (e) {
      emit(AuthFailure(error: "Login failed"));
    }
  }
}