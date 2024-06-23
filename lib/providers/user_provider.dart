import 'package:flutter/material.dart';
import 'package:vible_wallet_clone/models/user.dart';
import 'package:vible_wallet_clone/models/wallet.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    status: '',
    token: '',
    username: '',
    email: '',
    isVerified: false,
    role: '',
    balance: 0,
    firstName: '',
    lastName: '',
    ownerId: '',
    walletAddress: '',
    hasWallet: false,
    lastLogin: '',
    profilePictureUrl: '',
  );

  final List<Wallet> _wallets = [];

  User get user => _user;
  List<Wallet> get wallets => _wallets;

  void setUser(Map<String, dynamic> user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserHasWallet(bool walletStatus) {
    _user = _user.copyWith(hasWallet: walletStatus);
  }

  void addNewWallet(Wallet newWallet) {
    _wallets.add(newWallet);
  }
}
