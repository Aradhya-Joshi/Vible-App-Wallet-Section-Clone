import 'package:json_annotation/json_annotation.dart';

part 'request_airdrop_request.g.dart';

@JsonSerializable()
class RequestAirdropRequest {
  @JsonKey(name: 'wallet_address')
  final String walletAddress;

  final String network;

  final double amount;

  RequestAirdropRequest({
    required this.walletAddress,
    required this.network,
    required this.amount,
  });

  factory RequestAirdropRequest.fromJson(Map<String, dynamic> json) =>
      _$RequestAirdropRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestAirdropRequestToJson(this);
}

// {
//     "wallet_address": "AxLXd6SsHBHB4HWhRMACuGsuvbtfEq1MsXQqhPaF6wkS",
//     "network": "devnet",
//     "amount": 1
// }