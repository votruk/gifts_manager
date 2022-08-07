import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'create_account_request_dto.g.dart';

@JsonSerializable()
class CreateAccountRequestDto extends Equatable {
  final String email;
  final String password;
  final String name;
  final String avatarUrl;

  factory CreateAccountRequestDto.fromJson(final Map<String, dynamic> json) =>
      _$CreateAccountRequestDtoFromJson(json);

  const CreateAccountRequestDto({
    required this.email,
    required this.password,
    required this.name,
    required this.avatarUrl,
  });

  Map<String, dynamic> toJson() => _$CreateAccountRequestDtoToJson(this);

  @override
  List<Object?> get props => [email, password, name, avatarUrl];
}
