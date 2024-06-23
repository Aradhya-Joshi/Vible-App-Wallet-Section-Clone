import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vible_wallet_clone/models/balance_transfer_request.dart';
import 'package:vible_wallet_clone/models/create_wallet_request.dart';
import 'package:vible_wallet_clone/models/get_wallet_balance_response.dart';
import 'package:vible_wallet_clone/models/request_airdrop_request.dart';
import 'package:vible_wallet_clone/models/wallet.dart';
import 'package:vible_wallet_clone/providers/transaction_provider.dart';
import 'package:vible_wallet_clone/providers/user_provider.dart';
import 'package:vible_wallet_clone/utils/http_response_handler.dart';

class WalletServices {
  // Not taken values directly from providers as they may cause context conflicts.

  Future<void> createWallet({
    required BuildContext context,
    required String walletName,
    required String network,
    required String userPin,
  }) async {
    try {
      late final Wallet walletDetails;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? flicToken = prefs.getString('Flic-Token');

      const url = 'https://api.socialverseapp.com/solana/wallet/create';

      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Flic-Token': flicToken!,
      };

      CreateWalletRequest createWalletRequest = CreateWalletRequest(
        walletName: walletName,
        network: network,
        userPin: userPin,
      );

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(createWalletRequest.toJson()),
      );

      // Handle the response
      httpResponseHandler(response);

      walletDetails = Wallet.fromJson(jsonDecode(response.body));

      UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);

      userProvider.addNewWallet(walletDetails);

      // If no exception is thrown, the wallet is created successfully
      print('Wallet created successfully: ${response.body}');
    } on http.ClientException catch (e) {
      print('Client error occurred: $e');
    } on FormatException catch (e) {
      print('Bad response format: $e');
    } on Exception catch (e) {
      print('Unexpected error occurred: $e');
    }
  }

  Future<void> transferBalance({
    required BuildContext context,
    required int userPin,
  }) async {
    try {
      TransactionProvider transactionProvider =
          Provider.of<TransactionProvider>(context, listen: false);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? flicToken = prefs.getString('Flic-Token');

      const url = 'https://api.socialverseapp.com/solana/wallet/transfer';

      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Flic-Token': flicToken!,
      };

      BalanceTransferRequest balanceTransferRequest = BalanceTransferRequest(
        recipientAddress: transactionProvider.recipientAddress,
        network: transactionProvider.selectedNetwork,
        senderAddress: Provider.of<UserProvider>(context, listen: false)
            .user
            .walletAddress,
        amount: double.parse(transactionProvider.amount),
        userPin: userPin,
      );

      // print(
      //     'recipientAddress: ${transactionProvider.recipientAddress}\nnetwork: ${transactionProvider.selectedNetwork}\namount: ${transactionProvider.amount}\nuserPin: $userPin');

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(
          balanceTransferRequest.toJson(),
        ),
      );

      // Handle the response
      httpResponseHandler(response);

      final responseMessage = jsonDecode(response.body);

      // print(responseMessage);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Column(
          children: [
            Text(
                'Status: ${responseMessage['status']}\n${responseMessage['message']}\nTransaction Id: ${responseMessage['transaction_id']}'),
          ],
        )),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Balance successfully transfered')),
      );

      return Future.value();
    } on http.ClientException catch (e) {
      print('Client error occurred: $e');
    } on FormatException catch (e) {
      print('Bad response format: $e');
    } on Exception catch (e) {
      print('Unexpected error occurred: $e');
    }
  }

  Future<double> getWalletBalance({
    required BuildContext context,
    required String network,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? flicToken = prefs.getString('Flic-Token');

      const baseUrl = 'https://api.socialverseapp.com/solana/wallet/balance';

      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Flic-Token': flicToken!,
      };

      final Map<String, String> queryParams = {
        'network': network,
        'wallet_address': Provider.of<UserProvider>(context, listen: false)
            .user
            .walletAddress,
      };

      // print(
      //     'Network: $network , Wallet Address: ${Provider.of<UserProvider>(context, listen: false).user.walletAddress}');

      // Constructing the URI with query parameters
      final uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);

      final response = await http.get(
        uri,
        headers: headers,
      );

      // Handle the response
      httpResponseHandler(response);

      GetWalletBalanceResponse getWalletBalanceResponse =
          GetWalletBalanceResponse.fromJson(jsonDecode(response.body));

      // print(getWalletBalanceResponse.balance);

      return Future.value(getWalletBalanceResponse.balance);
    } on http.ClientException catch (e) {
      print('Client error occurred: $e');
      return Future.value(0);
    } on FormatException catch (e) {
      print('Bad response format: $e');
      return Future.value(0);
    } on Exception catch (e) {
      print('Unexpected error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            children: [Text(e.toString())],
          ),
        ),
      );
      return Future.value(0);
    }
  }

  Future<void> requestAirDrop({
    required BuildContext context,
    required double amount,
  }) async {
    try {
      TransactionProvider transactionProvider =
          Provider.of<TransactionProvider>(context, listen: false);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? flicToken = prefs.getString('Flic-Token');

      const url = 'https://api.socialverseapp.com/solana/wallet/airdrop';

      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Flic-Token': flicToken!,
      };

      RequestAirdropRequest requestAirdropRequest = RequestAirdropRequest(
        walletAddress: Provider.of<UserProvider>(context, listen: false)
            .user
            .walletAddress,
        network: transactionProvider.selectedNetwork,
        amount: amount,
      );

      // print(
      //     'recipientAddress: ${transactionProvider.recipientAddress}\nnetwork: ${transactionProvider.selectedNetwork}\namount: ${transactionProvider.amount}\nuserPin: $userPin');

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(
          requestAirdropRequest.toJson(),
        ),
      );

      // Handle the response
      httpResponseHandler(response);

      final responseMessage = jsonDecode(response.body);

      // print(responseMessage);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Column(
          children: [
            Text(
                'Status: ${responseMessage['status']}\n${responseMessage['message']}\nTransaction Id: ${responseMessage['transaction_id']}'),
          ],
        )),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Air Drop successfully requested')),
      );

      return Future.value();
    } on http.ClientException catch (e) {
      print('Client error occurred: $e');
    } on FormatException catch (e) {
      print('Bad response format: $e');
    } on Exception catch (e) {
      print('Unexpected error occurred: $e');
    }
  }
}
