part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final bool emailValid;
  final bool passwordValid;
  final bool authenticated;

  const LoginState({
    required this.email,
    required this.password,
    required this.emailValid,
    required this.passwordValid,
    required this.authenticated,
  });

  factory LoginState.initial() => const LoginState(
        email: '',
        password: '',
        emailValid: false,
        passwordValid: false,
        authenticated: false,
      );

  LoginState copyWith({
    final String? email,
    final String? password,
    final bool? emailValid,
    final bool? passwordValid,
    final bool? authenticated,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailValid: emailValid ?? this.emailValid,
      passwordValid: passwordValid ?? this.passwordValid,
      authenticated: authenticated ?? this.authenticated,
    );
  }

  @override
  List<Object?> get props =>
      [email, password, emailValid, passwordValid, authenticated];
}
