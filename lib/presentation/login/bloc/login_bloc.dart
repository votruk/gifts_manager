import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<LoginLoginButtonClicked>(_loginButtonClicked);
  }

  FutureOr<void> _loginButtonClicked(
    LoginLoginButtonClicked event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(authenticated: true));
  }

  @override
  void onEvent(LoginEvent event) {
    debugPrint('Login Bloc. Event happened: $event');
    super.onEvent(event);
  }

  @override
  void onTransition(Transition<LoginEvent, LoginState> transition) {
    debugPrint('Login Bloc. Transition happened: $transition');
    super.onTransition(transition);
  }
}
