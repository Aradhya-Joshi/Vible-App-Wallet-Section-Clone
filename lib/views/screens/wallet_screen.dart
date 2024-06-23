import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vible_wallet_clone/providers/transaction_provider.dart';
import 'package:vible_wallet_clone/providers/user_provider.dart';
import 'package:vible_wallet_clone/views/screens/send_screen.dart';
import 'package:vible_wallet_clone/services/wallet_services.dart';
import 'package:vible_wallet_clone/style/global_consts.dart';
import 'package:vible_wallet_clone/views/widgets/my_scaffold.dart';
import 'package:vible_wallet_clone/views/widgets/transaction_ledger_section.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  List<String> sendMeans = ['Address', 'Username'];
  List<IconData> sendMeansIcon = [Icons.wallet, Icons.person_outline_outlined];

  bool _isRefreshing = false;

  final WalletServices walletServices = WalletServices();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    final TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);

    return MyScaffold(
      myAppBar: AppBar(
        title: const Text(
          'Wallet',
        ),
        actions: [
          const CircleAvatar(
            maxRadius: 5,
            backgroundColor: Colors.deepPurple,
          ),
          const SizedBox(width: 3),
          InkWell(
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              changeNetwork(context);
            },
            child: Text(transactionProvider.selectedNetwork),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: PopupMenuButton(
              icon: const Icon(Icons.more_vert), // Vertical dots icon
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                const PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.qr_code_scanner_rounded),
                    title: Text('Account Details'),
                  ),
                ),
                const PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.link),
                    title: Text('View on explorer'),
                    subtitle: Text('polygonscan.com'),
                  ),
                ),
              ],
              onSelected: (value) {
                // Handle menu item selection if needed
                print('Selected: $value');
              },
            ),
          ),
        ],
      ),
      myBody: Stack(
        children: [
          RefreshIndicator(
            displacement: 5,
            onRefresh: () async {
              setState(() {
                _isRefreshing = true; // Start refresh indicator
              });

              await Future.delayed(const Duration(seconds: 3));

              print('refresh');

              setState(() {
                _isRefreshing = false; // Stop refresh indicator
              });

              return Future.value();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: FutureBuilder(
                future: checkAndCreateWallet(userProvider),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    // If wallet is still not found after potential creation attempt
                    if (!userProvider.user.hasWallet) {
                      return const Center(
                        child: Text('No wallet found. Kindly try again later'),
                      );
                    }

                    return FutureBuilder(
                      future: walletServices.getWalletBalance(
                          context: context,
                          network: transactionProvider.selectedNetwork),
                      builder: (BuildContext context,
                          AsyncSnapshot<double> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return createWalletScreen(
                          context,
                          snapshot.data!,
                          formatWalletAddress(
                            userProvider.user.walletAddress,
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
          if (_isRefreshing)
            Container(
              color: Colors.black
                  .withOpacity(0.5), // Semi-transparent black overlay
              // child: const Center(
              //   child: CircularProgressIndicator(),
              // ),
            ),
        ],
      ),
    );
  }

  String formatWalletAddress(String address) {
    if (address.length <= 10) {
      return address;
    }
    return '${address.substring(0, 5)}...${address.substring(address.length - 4)}';
  }

  Widget createWalletScreen(
      BuildContext context, double balance, String userWalletAddress) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: GlobalStyleVariables.screenWidth * 0.02,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: GlobalStyleVariables.screenHeight * 0.15,
            width: GlobalStyleVariables.screenWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black,
            ),
            clipBehavior: Clip.hardEdge,
            padding: EdgeInsets.symmetric(
              horizontal: GlobalStyleVariables.screenWidth * 0.05,
              vertical: GlobalStyleVariables.screenHeight * 0.005,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Total Balance', style: GlobalStyleVariables.textWhite),
                  Text('\$$balance', style: GlobalStyleVariables.textWhite),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        userWalletAddress,
                        style: GlobalStyleVariables.textWhite,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.copy,
                          color: Colors.white,
                          size: Theme.of(context).textTheme.bodySmall!.fontSize,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: GlobalStyleVariables.screenSpacer * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  onTapSend(context);
                },
                child: Container(
                  height: GlobalStyleVariables.screenHeight * 0.07,
                  width: GlobalStyleVariables.screenWidth * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.blue,
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: SizedBox(
                    child: Center(
                      child: Text(
                        'Send',
                        style: GlobalStyleVariables.textWhite,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    _onTapSwap(),
                  );
                },
                child: Container(
                  height: GlobalStyleVariables.screenSpacer * 0.07,
                  width: GlobalStyleVariables.screenWidth * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.red,
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: SizedBox(
                    width: GlobalStyleVariables.screenWidth * 0.3,
                    child: Center(
                      child: Text(
                        'Swap',
                        style: GlobalStyleVariables.textWhite,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: GlobalStyleVariables.screenSpacer * 0.03),
          const TransactionLedgerSection(),
        ],
      ),
    );
  }

  Route _onTapSwap() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
        appBar: AppBar(
          title: const Text('Swap Screen'),
        ),
        body: const Center(
          child: Placeholder(),
        ),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  Future<dynamic> onTapSend(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheet(
          onClosing: () {},
          builder: (context) {
            return SizedBox(
              height: GlobalStyleVariables.screenHeight * 0.3,
              width: GlobalStyleVariables.screenWidth,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: InkWell(
                      onTap: () {
                        navigateToNextScreen(index, context);
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          child: Icon(
                            sendMeansIcon[index],
                            color: Colors.black,
                          ),
                        ),
                        title: Text(sendMeans[index]),
                      ),
                    ),
                  );
                },
                itemCount: 2,
              ),
            );
          },
        );
      },
    );
  }

  void navigateToNextScreen(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SendScreen(
              sendByAddress: true,
            ),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SendScreen(),
          ),
        );
        break;

      default:
        Navigator.pop(context);
    }
  }

  Future<dynamic> changeNetwork(BuildContext context) {
    final TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text('Select a network')),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: GlobalStyleVariables.screenHeight * 0.12,
                  width: GlobalStyleVariables.screenWidth * 0.8,
                  child: ListView.separated(
                    itemCount: 2,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        color: transactionProvider.availableNetworks[index] ==
                                transactionProvider.selectedNetwork
                            ? Colors.amber
                            : null,
                        child: InkWell(
                          onTap: () {
                            transactionProvider.selectedNetwork =
                                transactionProvider.availableNetworks[index];

                            Navigator.pop(context);
                          },
                          child: ListTile(
                            title: Text(
                                transactionProvider.availableNetworks[index]),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 5),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> checkAndCreateWallet(UserProvider userProvider) async {
    String walletName = '';
    String network = '';
    String userPin = '';
    if (!userProvider.user.hasWallet) {
      bool createWallet = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                title: const Text('No wallet found'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Do you want to create a new wallet?'),
                      const SizedBox(height: 16),
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Wallet Name',
                        ),
                        onChanged: (value) {
                          walletName = value;
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: network,
                        hint: const Text('Select Network'),
                        onChanged: (value) {
                          setState(() {
                            network = value!;
                          });
                        },
                        items: ['Mainnet', 'Devnet']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'PIN',
                        ),
                        onChanged: (value) {
                          userPin = value;
                        },
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  TextButton(
                    child: const Text('Create'),
                    onPressed: () {
                      if (walletName.isNotEmpty &&
                          network.isNotEmpty &&
                          userPin.isNotEmpty) {
                        Navigator.of(context).pop(true);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill all fields'),
                          ),
                        );
                      }
                    },
                  ),
                ],
              );
            },
          );
        },
      );

      if (createWallet == true) {
        // Show snackbar indicating wallet creation is in progress
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Creating a new wallet...')),
        );

        // Call your function to create a wallet
        try {
          await WalletServices().createWallet(
            context: context,
            walletName: walletName,
            network: network,
            userPin: userPin,
          );

          // Assuming the createWallet method completes successfully,
          // Update the user's wallet status in the provider or wherever it's managed
          UserProvider userProvider =
              Provider.of<UserProvider>(context, listen: false);
          userProvider.setUserHasWallet(true);

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Wallet created successfully')),
          );
        } catch (e) {
          // Handle any errors that occur during wallet creation
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to create wallet: $e')),
          );
        }
      }
    }
  }
}
