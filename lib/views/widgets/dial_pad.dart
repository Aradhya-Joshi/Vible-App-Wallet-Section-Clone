import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vible_wallet_clone/providers/transaction_provider.dart';
import 'package:vible_wallet_clone/style/global_consts.dart';

class DialPad extends StatefulWidget {
  final double walletBalance;
  const DialPad({super.key, required this.walletBalance});

  @override
  State<DialPad> createState() => _DialPadState();
}

class _DialPadState extends State<DialPad> {
  String enteredNumber = '0';

  String _selectedItem = 'VIBLE';

  void _onPressed(String value) {
    setState(() {
      if (value == 'DEL') {
        if (enteredNumber.isNotEmpty) {
          enteredNumber = enteredNumber.substring(0, enteredNumber.length - 1);
        }
      } else {
        enteredNumber += value;

        Provider.of<TransactionProvider>(context, listen: false).amount =
            enteredNumber;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      enteredNumber,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: GlobalStyleVariables.screenWidth * 0.08,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' ${widget.walletBalance} - $enteredNumber',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    DropdownButton<String>(
                      value: _selectedItem,
                      icon: const Icon(Icons.arrow_downward),
                      onChanged: (String? newValue) {
                        setState(() {
                          transactionProvider.selectedCurrency = newValue!;
                          _selectedItem = newValue;
                        });
                      },
                      items: transactionProvider.availableCurrencies
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            children: [
                              const CircleAvatar(),
                              const SizedBox(width: 8),
                              Text(
                                value,
                                style: TextStyle(
                                  fontSize:
                                      GlobalStyleVariables.screenWidth * 0.08,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'AMOUNT',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 12,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.01,
            ),
            itemBuilder: (context, index) {
              String text;
              if (index < 9) {
                text = '${index + 1}';
              } else if (index == 9) {
                text = '.';
              } else if (index == 10) {
                text = '0';
              } else {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.backspace),
                    onPressed: () => _onPressed('DEL'),
                    iconSize: 26,
                  ),
                );
              }
              return GestureDetector(
                onTap: () => _onPressed(text),
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: Center(
                    child: Text(
                      text,
                      style: TextStyle(
                          fontSize: GlobalStyleVariables.screenSpacer * 0.03,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
