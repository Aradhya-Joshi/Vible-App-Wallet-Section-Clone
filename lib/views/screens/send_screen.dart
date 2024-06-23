import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vible_wallet_clone/providers/transaction_provider.dart';
import 'package:vible_wallet_clone/providers/user_provider.dart';
import 'package:vible_wallet_clone/views/screens/enter_pin_screen.dart';
import 'package:vible_wallet_clone/services/wallet_services.dart';
import 'package:vible_wallet_clone/style/global_consts.dart';
import 'package:vible_wallet_clone/views/widgets/dial_pad.dart';
import 'package:vible_wallet_clone/views/widgets/my_scaffold.dart';

class SendScreen extends StatefulWidget {
  final bool sendByAddress;

  const SendScreen({
    super.key,
    this.sendByAddress = false,
  });

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  // bool _loadingWalletBalance = false;
  WalletServices walletServices = WalletServices();

  final TextEditingController _recepientAddressController =
      TextEditingController();

  final GlobalKey<FormState> _sendFormKey = GlobalKey<FormState>();

  // late final double walletBalance;

  @override
  void initState() {
    super.initState();

    // loadingBalance();
  }

  @override
  void dispose() {
    _recepientAddressController.dispose();
    super.dispose();
  }

  // Future<void> loadingBalance(final String network) async {
  //   setState(() {
  //     _loadingWalletBalance = true;
  //   });
  //   walletBalance = await walletServices.getWalletBalance(
  //     context: context,
  //     network: network,
  //   );
  //   setState(() {
  //     _loadingWalletBalance = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return MyScaffold(
      myAppBar: AppBar(
        title: const Text('Send'),
        centerTitle: true,
      ),
      myBody:
          // _loadingWalletBalance
          //     ? const Center(
          //         child: CircularProgressIndicator(),
          //       )
          //     :

          Padding(
        padding: EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: GlobalStyleVariables.screenWidth * 0.05,
        ),
        child: Form(
          key: _sendFormKey,
          child: Column(
            children: [
              TextFormField(
                controller: _recepientAddressController,
                cursorColor: Colors.blue,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return widget.sendByAddress
                        ? 'Recipient address cannot be empty'
                        : 'Recipient username cannot be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: widget.sendByAddress
                      ? 'Recipient Address'
                      : 'Recipient Username',
                  suffixIcon: const Icon(Icons.wallet),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(height: GlobalStyleVariables.screenSpacer * 0.03),
                    Expanded(
                      child: DialPad(walletBalance: userProvider.user.balance),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        TransactionProvider transactionProvider =
                            Provider.of<TransactionProvider>(context,
                                listen: false);

                        // print(double.parse(transactionProvider.amount)
                        //     .toDouble());

                        if (double.parse(transactionProvider.amount)
                                .toDouble() >
                            0.0) {
                          if (_sendFormKey.currentState!.validate()) {
                            transactionProvider.recipientAddress =
                                _recepientAddressController.text;

                            Navigator.push(
                              context,
                              navigateToPinEntryScreen(),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Enter valid quantity (Qty. > 0)'),
                            ),
                          );
                        }
                      },
                      child: const Center(
                        child: Text('Send'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PageRouteBuilder<dynamic> navigateToPinEntryScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const EnterPinScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
