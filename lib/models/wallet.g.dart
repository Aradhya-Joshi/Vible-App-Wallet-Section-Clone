// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wallet _$WalletFromJson(Map<String, dynamic> json) => Wallet(
      walletName: json['walletName'] as String,
      userPin: json['userPin'] as String,
      network: json['network'] as String,
      publicKey: json['publicKey'] as String,
      secretKey: (json['secretKey'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
      'walletName': instance.walletName,
      'userPin': instance.userPin,
      'network': instance.network,
      'publicKey': instance.publicKey,
      'secretKey': instance.secretKey,
    };
