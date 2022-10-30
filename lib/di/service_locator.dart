import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gift_manager/data/http/authorization_interceptor.dart';
import 'package:gift_manager/data/http/authorized_api_service.dart';
import 'package:gift_manager/data/http/dio_provider.dart';
import 'package:gift_manager/data/http/unauthorized_api_service.dart';
import 'package:gift_manager/data/repository/refresh_token_provider.dart';
import 'package:gift_manager/data/repository/refresh_token_repository.dart';
import 'package:gift_manager/data/repository/token_repository.dart';
import 'package:gift_manager/data/repository/user_repository.dart';
import 'package:gift_manager/data/storage/shared_preference_data.dart';
import 'package:gift_manager/domain/logout_interactor.dart';
import 'package:gift_manager/presentation/gifts/bloc/gifts_bloc.dart';
import 'package:gift_manager/presentation/home/bloc/home_bloc.dart';
import 'package:gift_manager/presentation/login/bloc/login_bloc.dart';
import 'package:gift_manager/presentation/registration/bloc/registration_bloc.dart';
import 'package:gift_manager/presentation/splash/bloc/splash_bloc.dart';

final sl = GetIt.instance;

const _notAuthorizedDio = 'notAuthorizedDio';
const _authorizedDio = 'authorizedDio';

void initServiceLocator() {
  _setupDataProviders();
  _setupRepositories();
  _setupInteractors();
  _setupComplexInteractors();
  _setupApiRelatedClasses();
  _setupBlocs();
}

/// ONLY SINGLETONS
void _setupDataProviders() {
  sl.registerLazySingleton(() => SharedPreferenceData());
  sl.registerLazySingleton<RefreshTokenProvider>(
    () => sl.get<SharedPreferenceData>(),
  );
}

/// ONLY SINGLETONS
void _setupRepositories() {
  sl.registerLazySingleton(
    () => RefreshTokenRepository(sl.get<RefreshTokenProvider>()),
  );
  sl.registerLazySingleton(
    () => UserRepository(sl.get<SharedPreferenceData>()),
  );
  sl.registerLazySingleton(
    () => TokenRepository(sl.get<SharedPreferenceData>()),
  );
}

/// ONLY SINGLETONS
void _setupInteractors() {
  sl.registerLazySingleton(
    () => LogoutInteractor(
      userRepository: sl.get<UserRepository>(),
      tokenRepository: sl.get<TokenRepository>(),
      refreshTokenRepository: sl.get<RefreshTokenRepository>(),
    ),
  );
}

/// ONLY SINGLETONS
void _setupComplexInteractors() {}

void _setupApiRelatedClasses() {
  sl.registerFactory(() => DioBuilder());
  sl.registerLazySingleton(
    () => AuthorizationInterceptor(
      tokenRepository: sl.get<TokenRepository>(),
      logoutInteractor: sl.get<LogoutInteractor>(),
    ),
  );
  sl.registerSingleton<Dio>(
    sl.get<DioBuilder>().build(),
    instanceName: _notAuthorizedDio,
  );
  sl.registerSingleton<Dio>(
    sl
        .get<DioBuilder>()
        .addAuthorizationInterceptor(sl.get<AuthorizationInterceptor>())
        .build(),
    instanceName: _authorizedDio,
  );
  sl.registerLazySingleton(
    () => UnauthorizedApiService(sl.get<Dio>(instanceName: _notAuthorizedDio)),
  );
  sl.registerLazySingleton(
    () => AuthorizedApiService(sl.get<Dio>(instanceName: _authorizedDio)),
  );
}

/// ONLY FACTORIES
void _setupBlocs() {
  sl.registerFactory(
    () => LoginBloc(
      userRepository: sl.get<UserRepository>(),
      tokenRepository: sl.get<TokenRepository>(),
      refreshTokenRepository: sl.get<RefreshTokenRepository>(),
      unauthorizedApiService: sl.get<UnauthorizedApiService>(),
    ),
  );
  sl.registerFactory(
    () => RegistrationBloc(
      userRepository: sl.get<UserRepository>(),
      tokenRepository: sl.get<TokenRepository>(),
      refreshTokenRepository: sl.get<RefreshTokenRepository>(),
      unauthorizedApiService: sl.get<UnauthorizedApiService>(),
    ),
  );
  sl.registerFactory(
    () => SplashBloc(
      tokenRepository: sl.get<TokenRepository>(),
    ),
  );
  sl.registerFactory(
    () => HomeBloc(
      userRepository: sl.get<UserRepository>(),
      logoutInteractor: sl.get<LogoutInteractor>(),
      authorizedApiService: sl.get<AuthorizedApiService>(),
      unauthorizedApiService: sl.get<UnauthorizedApiService>(),
      refreshTokenRepository: sl.get<RefreshTokenRepository>(),
      tokenRepository: sl.get<TokenRepository>(),
    ),
  );
  sl.registerFactory(
    () => GiftsBloc(
      authorizedApiService: sl.get<AuthorizedApiService>(),
    ),
  );
}
