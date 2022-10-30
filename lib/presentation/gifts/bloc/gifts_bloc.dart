import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gift_manager/data/http/authorized_api_service.dart';
import 'package:gift_manager/data/http/model/gift_dto.dart';

part 'gifts_event.dart';

part 'gifts_state.dart';

class GiftsBloc extends Bloc<GiftsEvent, GiftsState> {
  GiftsBloc({
    required this.authorizedApiService,
  }) : super(const InitialGiftsLoadingState()) {
    on<GiftsPageLoaded>(_onGiftsPageLoaded);
    on<GiftsLoadingRequest>(_onGiftsLoadingRequest);
    on<GiftsAutoLoadingRequest>(_onGiftsAutoLoadingRequest);
  }

  static const _limit = 10;

  final AuthorizedApiService authorizedApiService;

  final gifts = <GiftDto>[];

  PaginationInfo paginationInfo = PaginationInfo.initial();
  bool errorHappened = false;
  bool loading = false;

  FutureOr<void> _onGiftsPageLoaded(
    GiftsPageLoaded event,
    Emitter<GiftsState> emit,
  ) async {
    await _loadGifts(emit);
  }

  FutureOr<void> _onGiftsLoadingRequest(
    GiftsLoadingRequest event,
    Emitter<GiftsState> emit,
  ) async {
    await _loadGifts(emit);
  }

  FutureOr<void> _onGiftsAutoLoadingRequest(
    GiftsAutoLoadingRequest event,
    Emitter<GiftsState> emit,
  ) async {
    if (errorHappened) {
      return;
    }
    await _loadGifts(emit);
  }

  FutureOr<void> _loadGifts(
    Emitter<GiftsState> emit,
  ) async {
    if (loading) {
      return;
    }
    if (!paginationInfo.canLoadMore) {
      return;
    }
    loading = true;
    if (gifts.isEmpty) {
      emit(const InitialGiftsLoadingState());
    } else {
      emit(
        LoadedGiftsState(gifts: gifts, showError: false, showLoading: true),
      );
    }
    final giftsResponse = await authorizedApiService.getAllGifts(
      limit: _limit,
      offset: paginationInfo.lastLoadedPage * _limit,
    );
    if (giftsResponse.isLeft) {
      errorHappened = true;
      if (gifts.isEmpty) {
        emit(const InitialLoadingErrorState());
      } else {
        emit(
          LoadedGiftsState(gifts: gifts, showError: true, showLoading: false),
        );
      }
    } else {
      errorHappened = false;
      final canLoadMore = giftsResponse.right.gifts.length == _limit;
      paginationInfo = PaginationInfo(
        canLoadMore: canLoadMore,
        lastLoadedPage: paginationInfo.lastLoadedPage + 1,
      );
      if (gifts.isEmpty && giftsResponse.right.gifts.isEmpty) {
        emit(const NoGiftsState());
      } else {
        gifts.addAll(giftsResponse.right.gifts);
        emit(
          LoadedGiftsState(
            gifts: [...gifts],
            showError: false,
            showLoading: canLoadMore,
          ),
        );
      }
    }
    loading = false;
  }
}

class PaginationInfo extends Equatable {
  const PaginationInfo({
    required this.canLoadMore,
    required this.lastLoadedPage,
  });

  factory PaginationInfo.initial() =>
      const PaginationInfo(canLoadMore: true, lastLoadedPage: 0);

  final bool canLoadMore;
  final int lastLoadedPage;

  @override
  List<Object?> get props => [canLoadMore, lastLoadedPage];
}
