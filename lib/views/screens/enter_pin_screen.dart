import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vible_wallet_clone/services/wallet_services.dart';
import 'package:vible_wallet_clone/style/global_consts.dart';
import 'package:vible_wallet_clone/views/widgets/my_scaffold.dart';

class EnterPinScreen extends StatefulWidget {
  const EnterPinScreen({
    super.key,
  });

  @override
  State<EnterPinScreen> createState() => _EnterPinScreenState();
}

class _EnterPinScreenState extends State<EnterPinScreen> {
  final TextEditingController _pinController = TextEditingController();

  final GlobalKey<FormState> _pinFormKey = GlobalKey<FormState>();

  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
        myAppBar: AppBar(
          title: const Text('Enter Pin'),
        ),
        myBody: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: GlobalStyleVariables.screenWidth * 0.05,
          ),
          child: Stack(
            children: [
              Form(
                key: _pinFormKey,
                child: Column(
                  children: [
                    PinCodeTextField(
                      appContext: context,
                      length: 6,
                      controller: _pinController,
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(8.0),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.grey[200],
                        selectedFillColor: Colors.grey[100],
                        inactiveFillColor: Colors.grey[200],
                        activeColor: Colors.blue,
                        selectedColor: Colors.blue,
                        inactiveColor: Colors.grey,
                      ),
                      cursorColor: Colors.blue,
                      enableActiveFill: true,
                      validator: (value) {
                        if (value == null || value.length != 6) {
                          return 'Please enter a 6-digit PIN';
                        }
                        return null;
                      },
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_pinFormKey.currentState!.validate()) {
                          await transferBalance();

                          Navigator.popUntil(context, (route) {
                            return route.settings.name == 'MainScreen';
                          });
                        }
                      },
                      child: const Center(
                        child: Text('Submit'),
                      ),
                    ),
                    // TextFormField(
                    //   controller: _pinController,
                    //   cursorColor: Colors.blue,
                    //   decoration: InputDecoration(
                    //     hintText: 'Enter PIN',
                    //     suffixIcon: const Icon(Icons.wallet),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //     focusedBorder: InputBorder.none,
                    //     enabledBorder: InputBorder.none,
                    //     disabledBorder: InputBorder.none,
                    //     filled: true,
                    //     fillColor: Colors.grey[200],
                    //   ),
                    //   keyboardType: TextInputType.number,
                    // ),
                  ],
                ),
              ),
              if (_isSubmitting)
                Container(
                  color: Colors.black
                      .withOpacity(0.5), // Semi-transparent black overlay
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        ));
  }

  Future<void> transferBalance() async {
    setState(() {
      _isSubmitting = true;
    });

    WalletServices walletServices = WalletServices();

    await walletServices.transferBalance(
      context: context,
      userPin: int.parse(_pinController.text),
    );

    setState(() {
      _isSubmitting = false;
    });
  }
}
