import 'package:fin_wealth/screens/market_screen.dart';
import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'search_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const MainScreen(),
    SearchScreen(),
    MarketScreen(),
    const ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home', // Empty label
            tooltip: 'Home', // Optional tooltip
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Stocks', // Empty label
            tooltip: 'Stocks', // Optional tooltip
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket_rounded),
            label: 'Market', // Empty label
            tooltip: 'Market', // Optional tooltip
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile', // Empty label
            tooltip: 'Profile', // Optional tooltip
          ),
        ],
        selectedItemColor: Colors.blue, // Color for the active tab
        unselectedItemColor: Colors.grey, // Color for inactive tabs

        type: BottomNavigationBarType
            .fixed, // Use fixed type to keep the layout consistent
      ),
    );
  }
}
