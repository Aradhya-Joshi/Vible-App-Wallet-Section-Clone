// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_wallet_balance_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetWalletBalanceResponse _$GetWalletBalanceResponseFromJson(
        Map<String, dynamic> json) =>
    GetWalletBalanceResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      balance: (json['balance'] as num).toDouble(),
    );

Map<String, dynamic> _$GetWalletBalanceResponseToJson(
        GetWalletBalanceResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'balance': instance.balance,
    };
