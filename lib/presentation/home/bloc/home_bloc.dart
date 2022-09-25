import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gift_manager/data/http/authorized_api_service.dart';
import 'package:gift_manager/data/http/model/gift_dto.dart';
import 'package:gift_manager/data/http/model/user_dto.dart';
import 'package:gift_manager/data/http/unauthorized_api_service.dart';
import 'package:gift_manager/data/repository/refresh_token_repository.dart';
import 'package:gift_manager/data/repository/token_repository.dart';
import 'package:gift_manager/data/repository/user_repository.dart';
import 'package:gift_manager/domain/logout_interactor.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository userRepository;
  final LogoutInteractor logoutInteractor;
  final AuthorizedApiService authorizedApiService;
  final UnauthorizedApiService unauthorizedApiService;
  final RefreshTokenRepository refreshTokenRepository;
  final TokenRepository tokenRepository;

  late final StreamSubscription _logoutSubscription;

  HomeBloc({
    required this.userRepository,
    required this.logoutInteractor,
    required this.authorizedApiService,
    required this.unauthorizedApiService,
    required this.refreshTokenRepository,
    required this.tokenRepository,
  }) : super(HomeInitial()) {
    on<HomePageLoaded>(_onHomePageLoaded);
    on<HomeLogoutPushed>(_onLogoutPushed);
    on<HomeExternalLogout>(_onHomeExternalLogout);
    _logoutSubscription = userRepository
        .observeItem()
        .where((user) => user == null)
        .take(1)
        .listen((_) => _logout());
  }

  FutureOr<void> _onHomePageLoaded(
    final HomePageLoaded event,
    final Emitter<HomeState> emit,
  ) async {
    final user = await userRepository.getItem();
    final refreshToken = await refreshTokenRepository.getItem();
    if (user == null || refreshToken == null) {
      _logout();
      return;
    }

    final refreshTokenResponse =
        await unauthorizedApiService.refreshToken(refreshToken: refreshToken);
    if (refreshTokenResponse.isLeft) {
      _logout();
      return;
    }
    await refreshTokenRepository
        .setItem(refreshTokenResponse.right.refreshToken);
    await tokenRepository.setItem(refreshTokenResponse.right.token);
    final giftsResponse = await authorizedApiService.getAllGifts();
    final gifts =
        giftsResponse.isRight ? giftsResponse.right.gifts : const <GiftDto>[];
    print('GOT GIFTS: $gifts');
    emit(HomeWithUserInfo(user: user, gifts: gifts));
  }

  FutureOr<void> _onHomeExternalLogout(
    final HomeExternalLogout event,
    final Emitter<HomeState> emit,
  ) async {
    emit(const HomeGoToLogin());
  }

  FutureOr<void> _onLogoutPushed(
    final HomeLogoutPushed event,
    final Emitter<HomeState> emit,
  ) async {
    await logoutInteractor.logout();
    _logout();
  }

  void _logout() {
    add(const HomeExternalLogout());
  }

  @override
  Future<void> close() {
    _logoutSubscription.cancel();
    return super.close();
  }
}
