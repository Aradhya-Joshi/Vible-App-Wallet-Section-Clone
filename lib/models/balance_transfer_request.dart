import 'package:json_annotation/json_annotation.dart';

part 'balance_transfer_request.g.dart';

@JsonSerializable()
class BalanceTransferRequest {
  @JsonKey(name: 'recipient_address')
  final String recipientAddress;

  final String network;

  @JsonKey(name: 'sender_address')
  final String senderAddress;

  final double amount;

  @JsonKey(name: 'user_pin')
  final int userPin;

  BalanceTransferRequest({
    required this.recipientAddress,
    required this.network,
    required this.senderAddress,
    required this.amount,
    required this.userPin,
  });
  factory BalanceTransferRequest.fromJson(Map<String, dynamic> json) =>
      _$BalanceTransferRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BalanceTransferRequestToJson(this);
}

// {
//     "recipient_address": "AxLXd6SsHBHB4HWhRMACuGsuvbtfEq1MsXQqhPaF6wkS",
//     "network": "devnet",
//     "sender_address": "6LD7oF4QgDaSRwwGGbgUBAZCC3hLNF1PFn6xxDcLKwgA",
//     "amount": 130,
//     "user_pin": "123456"
// }