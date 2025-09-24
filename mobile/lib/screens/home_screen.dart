import 'package:flutter/material.dart';

// Main Home Screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Track selected tab

  // List of screens (blank for now)
  final List<Widget> _screens = [
    const TicketsScreen(),
    const PurchaseScreen(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex], // Show the selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update selected tab
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number), // Ticket icon
            label: "Tickets",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), // Cart icon
            label: "Purchase",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), // Account icon
            label: "Account",
          ),
        ],
      ),
    );
  }
}

// Blank Screens
class TicketsScreen extends StatelessWidget {
  const TicketsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Tickets Screen",
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Purchase Screen",
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Account Screen",
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
