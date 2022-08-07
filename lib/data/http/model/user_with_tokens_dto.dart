import 'package:equatable/equatable.dart';
import 'package:gift_manager/data/http/model/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_with_tokens_dto.g.dart';

@JsonSerializable()
class UserWithTokensDto extends Equatable {
  final String token;
  final String refreshToken;
  final UserDto user;

  const UserWithTokensDto({
    required this.token,
    required this.refreshToken,
    required this.user,
  });

  factory UserWithTokensDto.fromJson(final Map<String, dynamic> json) =>
      _$UserWithTokensDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserWithTokensDtoToJson(this);

  @override
  List<Object?> get props => [token, refreshToken, user];
}
