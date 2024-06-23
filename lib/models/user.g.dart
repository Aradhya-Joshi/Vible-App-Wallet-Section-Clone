// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      status: json['status'] as String,
      token: json['token'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      isVerified: json['isVerified'] as bool,
      role: json['role'] as String,
      balance: (json['balance'] as num).toDouble(),
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      ownerId: json['owner_id'] as String,
      walletAddress: json['wallet_address'] as String,
      hasWallet: json['has_wallet'] as bool,
      lastLogin: json['last_login'] as String,
      profilePictureUrl: json['profile_picture_url'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'status': instance.status,
      'token': instance.token,
      'username': instance.username,
      'email': instance.email,
      'role': instance.role,
      'isVerified': instance.isVerified,
      'balance': instance.balance,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'owner_id': instance.ownerId,
      'wallet_address': instance.walletAddress,
      'has_wallet': instance.hasWallet,
      'last_login': instance.lastLogin,
      'profile_picture_url': instance.profilePictureUrl,
    };
