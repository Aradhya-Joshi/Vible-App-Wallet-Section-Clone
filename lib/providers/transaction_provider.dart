import 'package:flutter/material.dart';

class TransactionProvider extends ChangeNotifier {
  String recipientAddress = '';
  String selectedNetwork = 'Polygon Mainnet'; // Default Network on opening.
  String amount = '0';
  // final int _userPin = 0;

  List<String> availableNetworks = [
    'Ploygon Mainnet',
    'Etherium Mainnet',
  ];

  List<String> availableCurrencies = [
    'VIBLE',
    'MATIC',
  ]; // Maintain the order and index positions and be sure to update the default selected item in dial pad widget.

  String selectedCurrency = '';
}
