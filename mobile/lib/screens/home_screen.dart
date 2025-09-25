import 'package:flutter/material.dart';
import 'account_screen.dart'; // Import the AccountScreen
import 'purchase_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _headerImage(BuildContext context) {
    const gold = Color.fromARGB(255, 243, 226, 143);

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final scale = (w / 375).clamp(0.85, 1.25);

  // List of screens - NOW INCLUDING THE PROPER ACCOUNT SCREEN
  final List<Widget> _screens = [
    const TicketsScreen(),
    const PurchaseScreen(),
    const AccountScreen(), // This now uses the real AccountScreen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, toolbarHeight: 8),
      body: Column(
        children: [
          SizedBox(
            height: 260,
            width: double.infinity,
            child: _headerImage(context),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isNarrow = constraints.maxWidth < 360;

                  final current = _actionTile(
                    icon: Icons.verified_outlined,
                    label: 'Current Valid Ticket',
                    onTap: () {
                      // Mock mapped to physical ticket
                      final mock = Ticket(
                        operatorName: 'AB SMILTYNES MOVES',
                        bookingRef: '0473825726', // use ticket number as ref
                        operatorRef:
                            'Company code 14085526', // extra operator identifier
                        departAt: DateTime.now().add(
                          const Duration(minutes: 20),
                        ),
                        duration: const Duration(minutes: 12),
                        vehicle: 'PASSENGER',
                        passengers: const ['Lead Passenger'],
                        legs: const [
                          Leg(
                            fromCity: 'Klaipėda',
                            fromCountry: 'Lithuania',
                            toCity: 'Smiltynė',
                            toCountry: 'Lithuania',
                          ),
                          Leg(
                            fromCity: 'Smiltynė', 
                            fromCountry: 'Lithuania',
                            toCity: 'Klaipėda',
                            toCountry: 'Lithuania',
                          ),
                        ],
                        barcodeData:
                            '0473825726', // equals printed ticket number
                      );

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CurrentTicketScreen(ticket: mock),
                        ),
                      );
                    },
                  );

                  final myTickets = _actionTile(
                    icon: Icons.folder_open_outlined,
                    label: 'My Tickets',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Open tickets list…')),
                      );
                    },
                  );

                  final purchase = _actionTile(
                    icon: Icons.confirmation_number_outlined,
                    label: 'Purchase Ticket',
                    onTap: () => AppShell.of(context)?.setTab(1),
                  );

                  final myAccount = _actionTile(
                    icon: Icons.account_circle_outlined,
                    label: 'My Account',
                    onTap: () =>
                        AppShell.of(context)?.setTab(2), // 👈 go to Account tab
                  );

                  if (isNarrow) {
                    return GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.2,
                      children: [current, myTickets, purchase, myAccount],
                    );
                  }

                  return Row(
                    children: [
                      Expanded(child: current),
                      const SizedBox(width: 12),
                      Expanded(child: myTickets),
                      const SizedBox(width: 12),
                      Expanded(child: purchase),
                      const SizedBox(width: 12),
                      Expanded(child: myAccount),
                    ],
                  );
                },
              ),
            ),
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


