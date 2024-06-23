import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vible_wallet_clone/providers/transaction_provider.dart';
import 'package:vible_wallet_clone/providers/user_provider.dart';
import 'package:vible_wallet_clone/views/screens/login_screen.dart';
import 'package:vible_wallet_clone/style/global_consts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ensure the app remains in portrait mode only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    GlobalStyleVariables styles = GlobalStyleVariables();
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        colorScheme: const ColorScheme.light(),
        typography: Typography.material2021(),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.black,
          elevation: 0,
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: FutureBuilder(
        future: styles.setScreenDimensions(context),
        builder: (context, snapshot) {
          return const LoginScreen();
        },
      ),
    );
  }
}
