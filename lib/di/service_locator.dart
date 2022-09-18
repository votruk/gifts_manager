import 'package:get_it/get_it.dart';
import 'package:gift_manager/data/http/dio_provider.dart';
import 'package:gift_manager/data/repository/refresh_token_provider.dart';
import 'package:gift_manager/data/repository/refresh_token_repository.dart';
import 'package:gift_manager/data/repository/token_repository.dart';
import 'package:gift_manager/data/repository/user_repository.dart';
import 'package:gift_manager/data/storage/shared_preference_data.dart';
import 'package:gift_manager/presentation/home/bloc/home_bloc.dart';
import 'package:gift_manager/presentation/login/bloc/login_bloc.dart';
import 'package:gift_manager/presentation/registration/bloc/registration_bloc.dart';
import 'package:gift_manager/presentation/splash/bloc/splash_bloc.dart';

final sl = GetIt.instance;

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
  sl.registerLazySingleton(() => DioProvider());
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
void _setupInteractors() {}

/// ONLY SINGLETONS
void _setupComplexInteractors() {}

/// ONLY SINGLETONS
void _setupApiRelatedClasses() {}

/// ONLY FACTORIES
void _setupBlocs() {
  sl.registerFactory(
    () => LoginBloc(
      userRepository: sl.get<UserRepository>(),
      tokenRepository: sl.get<TokenRepository>(),
      refreshTokenRepository: sl.get<RefreshTokenRepository>(),
    ),
  );
  sl.registerFactory(
    () => RegistrationBloc(
      userRepository: sl.get<UserRepository>(),
      tokenRepository: sl.get<TokenRepository>(),
      refreshTokenRepository: sl.get<RefreshTokenRepository>(),
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
    ),
  );
}
