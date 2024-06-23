import 'package:json_annotation/json_annotation.dart';

part 'get_wallet_balance_response.g.dart';

@JsonSerializable()
class GetWalletBalanceResponse {
  final String status, message;
  final double balance;

  GetWalletBalanceResponse({
    required this.status,
    required this.message,
    required this.balance,
  });

  factory GetWalletBalanceResponse.fromJson(Map<String, dynamic> json) =>
      _$GetWalletBalanceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetWalletBalanceResponseToJson(this);
}
