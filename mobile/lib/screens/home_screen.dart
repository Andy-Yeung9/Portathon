import 'package:flutter/material.dart';
import 'account_screen.dart'; // Import the AccountScreen
import 'purchase_screen.dart';

// Main Home Screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Track selected tab

  // List of screens - NOW INCLUDING THE PROPER ACCOUNT SCREEN
  final List<Widget> _screens = [
    const TicketsScreen(),
    const PurchaseScreen(),
    const AccountScreen(), // This now uses the real AccountScreen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Portathon App"),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
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
            icon: Icon(Icons.confirmation_number),
            label: "Tickets",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Purchase",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Account",
          ),
        ],
      ),
    );
  }
}

// Tickets Screen (you can customize this later)
class TicketsScreen extends StatelessWidget {
  const TicketsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Tickets Screen - Coming Soon!",
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}


