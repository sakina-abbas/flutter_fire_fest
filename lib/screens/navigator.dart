import 'package:flutter/material.dart';
import 'screens.dart';

class NavigatorScreen extends StatefulWidget {
  static String id = 'navigators';

  @override
  _NavigatorScreenState createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget callPage(int current) {
    switch (current) {
      case 0:
        return HomeScreen();
      case 1:
        return ProfileScreen();
        break;
      default:
        return HomeScreen();
    }
  }

  Future<bool> _onWillPop() {
    if (_selectedIndex > 0) {
      setState(() {
        _selectedIndex = 0;
      });

      return Future.value(false);
    } else
      return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: callPage(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.indigoAccent,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
