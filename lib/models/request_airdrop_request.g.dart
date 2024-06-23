// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_airdrop_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestAirdropRequest _$RequestAirdropRequestFromJson(
        Map<String, dynamic> json) =>
    RequestAirdropRequest(
      walletAddress: json['wallet_address'] as String,
      network: json['network'] as String,
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$RequestAirdropRequestToJson(
        RequestAirdropRequest instance) =>
    <String, dynamic>{
      'wallet_address': instance.walletAddress,
      'network': instance.network,
      'amount': instance.amount,
    };
