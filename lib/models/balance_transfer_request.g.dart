// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_transfer_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BalanceTransferRequest _$BalanceTransferRequestFromJson(
        Map<String, dynamic> json) =>
    BalanceTransferRequest(
      recipientAddress: json['recipient_address'] as String,
      network: json['network'] as String,
      senderAddress: json['sender_address'] as String,
      amount: (json['amount'] as num).toDouble(),
      userPin: (json['user_pin'] as num).toInt(),
    );

Map<String, dynamic> _$BalanceTransferRequestToJson(
        BalanceTransferRequest instance) =>
    <String, dynamic>{
      'recipient_address': instance.recipientAddress,
      'network': instance.network,
      'sender_address': instance.senderAddress,
      'amount': instance.amount,
      'user_pin': instance.userPin,
    };
