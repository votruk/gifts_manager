import 'dart:io';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:gift_manager/data/http/api_error_type.dart';
import 'package:gift_manager/data/http/base_api_service.dart';
import 'package:gift_manager/data/http/dio_provider.dart';
import 'package:gift_manager/data/http/model/api_error.dart';
import 'package:gift_manager/data/http/model/gifts_response_dto.dart';
import 'package:gift_manager/data/http/unauthorized_api_service.dart';

class AuthorizedApiService extends BaseApiService {
  final Dio _dio;
  final UnauthorizedApiService _unauthorizedApiService;
  final AsyncValueGetter<String> refreshTokenGetter;

  AuthorizedApiService(
      this._dio, this._unauthorizedApiService, this.refreshTokenGetter);

  Future<Either<ApiError, GiftsResponseDto>> getAllGifts({
    final int limit = 10,
    final int offset = 0,
  }) async {
    return _requestWithTokenRefresh(
      request: () async {
        return responseOrError(() async {
          final response = await _dio.get(
            '/user/gifts',
            queryParameters: {
              'limit': limit,
              'offset': offset,
            },
          );
          return GiftsResponseDto.fromJson(response.data);
        });
      },
      firstRequest: true,
    );
  }

  Future<Either<ApiError, GiftsResponseDto>> getMineGifts({
    final int limit = 10,
    final int offset = 0,
  }) async {
    return _requestWithTokenRefresh(
      request: () async {
        return responseOrError(() async {
          final response = await _dio.get(
            '/user/gifts/mine'
          );
          return GiftsResponseDto.fromJson(response.data);
        });
      },
      firstRequest: true,
    );
  }

  Future<Either<ApiError, TR>> _requestWithTokenRefresh<TR>({
    required Future<Either<ApiError, TR>> Function() request,
    required bool firstRequest,
  }) async {
    final response = await request();
    if (response.isLeft &&
        response.left.errorType == ApiErrorType.tokenExpired) {
      if (!firstRequest) {
        // await logoutInteractor.logout();
        return response;
      }
      final refreshToken = await refreshTokenGetter();
      final token = await _unauthorizedApiService.refreshToken(
          refreshToken: refreshToken);
      if (token.isLeft) {
        // await logoutInteractor.logout();
        return response;
      }
      //TODO save both tokens
      return _requestWithTokenRefresh(request: request, firstRequest: false);
    }
    return response;
  }

}
