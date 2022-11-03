import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gift_manager/data/repository/token_repository.dart';
import 'package:gift_manager/domain/logout_interactor.dart';

class AuthorizationInterceptor extends Interceptor {
  final TokenRepository tokenRepository;
  final LogoutInteractor logoutInteractor;

  AuthorizationInterceptor({
    required this.tokenRepository,
    required this.logoutInteractor,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await tokenRepository.getItem();
    if (token == null) {
      await logoutInteractor.logout();
      return handler.next(options);
    }
    options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    return handler.next(options);
  }

}
