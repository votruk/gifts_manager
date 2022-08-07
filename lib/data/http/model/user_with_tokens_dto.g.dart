// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_with_tokens_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWithTokensDto _$UserWithTokensDtoFromJson(Map<String, dynamic> json) =>
    UserWithTokensDto(
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
      user: UserDto.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserWithTokensDtoToJson(UserWithTokensDto instance) =>
    <String, dynamic>{
      'token': instance.token,
      'refreshToken': instance.refreshToken,
      'user': instance.user,
    };
