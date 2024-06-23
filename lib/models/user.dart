import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String status, token, username, email, role;

  final bool isVerified;

  final double balance;

  @JsonKey(name: 'first_name')
  final String firstName;

  @JsonKey(name: 'last_name')
  final String lastName;

  @JsonKey(name: 'owner_id')
  final String ownerId;

  @JsonKey(name: 'wallet_address')
  final String walletAddress;

  @JsonKey(name: 'has_wallet')
  final bool hasWallet;

  @JsonKey(name: 'last_login')
  final String lastLogin;

  @JsonKey(name: 'profile_picture_url')
  final String profilePictureUrl;

  User({
    required this.status,
    required this.token,
    required this.username,
    required this.email,
    required this.isVerified,
    required this.role,
    required this.balance,
    required this.firstName,
    required this.lastName,
    required this.ownerId,
    required this.walletAddress,
    required this.hasWallet,
    required this.lastLogin,
    required this.profilePictureUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? status,
    String? token,
    String? username,
    String? email,
    bool? isVerified,
    String? role,
    double? balance,
    String? firstName,
    String? lastName,
    String? ownerId,
    String? walletAddress,
    bool? hasWallet,
    String? lastLogin,
    String? profilePictureUrl,
  }) {
    return User(
      status: status ?? this.status,
      token: token ?? this.token,
      username: username ?? this.username,
      email: email ?? this.email,
      isVerified: isVerified ?? this.isVerified,
      role: role ?? this.role,
      balance: balance ?? this.balance,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      ownerId: ownerId ?? this.ownerId,
      walletAddress: walletAddress ?? this.walletAddress,
      hasWallet: hasWallet ?? this.hasWallet,
      lastLogin: lastLogin ?? this.lastLogin,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
    );
  }
}
