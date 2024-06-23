// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_wallet_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateWalletRequest _$CreateWalletRequestFromJson(Map<String, dynamic> json) =>
    CreateWalletRequest(
      walletName: json['wallet_name'] as String,
      network: json['network'] as String,
      userPin: json['user_pin'] as String,
    );

Map<String, dynamic> _$CreateWalletRequestToJson(
        CreateWalletRequest instance) =>
    <String, dynamic>{
      'wallet_name': instance.walletName,
      'network': instance.network,
      'user_pin': instance.userPin,
    };
