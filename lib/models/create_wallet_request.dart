import 'package:json_annotation/json_annotation.dart';

part 'create_wallet_request.g.dart';

@JsonSerializable()
class CreateWalletRequest {
  @JsonKey(name: 'wallet_name')
  final String walletName;

  final String network;

  @JsonKey(name: 'user_pin')
  final String userPin;

  CreateWalletRequest(
      {required this.walletName, required this.network, required this.userPin});

  factory CreateWalletRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateWalletRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateWalletRequestToJson(this);
}
