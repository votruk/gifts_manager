import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'user_with_tokens_dto.g.dart';

@JsonSerializable()
class UserWithTokensDto extends Equatable {

  final String token;
  final String refreshToken;

  const UserWithTokensDto({
    required this.token,
    required this.refreshToken,
  });

  factory UserWithTokensDto.fromJson(final Map<String, dynamic> json) => _$UserWithTokensDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserWithTokensDtoToJson(this);

  @override
  List<Object?> get props => throw UnimplementedError();
}