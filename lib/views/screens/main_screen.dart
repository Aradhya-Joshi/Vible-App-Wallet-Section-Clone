import 'package:flutter/material.dart';
import 'package:vible_wallet_clone/views/screens/wallet_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Index of the current active screen
  int _currentScreen = 0;

  // List of Screen Widgets
  List<Widget> screens = [
    const Placeholder(),
    const Placeholder(),
    const WalletScreen(),
    const Placeholder(),
  ];

  // Function to handle bottom navigation item taps
  void _onItemTapped(int index) {
    _currentScreen = index; // Update the selected index
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: _currentScreen,
          children: screens,
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            color: Colors.black,
          ),
          clipBehavior: Clip.hardEdge,
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.black,
            currentIndex: _currentScreen,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.wallet),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
