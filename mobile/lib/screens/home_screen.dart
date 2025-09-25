import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_shells.dart';
import '../models/ticket.dart';
import 'current_ticket_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _headerImage(BuildContext context) {
    const gold = Color.fromARGB(255, 243, 226, 143);

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final scale = (w / 375).clamp(0.85, 1.25);

        return Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/ferry_header.jpg',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Image.network(
                'https://images.unsplash.com/photo-1518611012118-696072aa579a?q=80&w=1600&auto=format&fit=crop',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black12, Colors.transparent, Colors.black26],
                  stops: [0.0, 0.45, 1.0],
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0, -0.06),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Left block
                    SizedBox(
                      width: w * 0.55,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Transform.translate(
                            offset: const Offset(0, -8),
                            child: Text(
                              'SMART TICKETING',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bebasNeue(
                                color: const Color.fromARGB(255, 54, 185, 174),
                                fontSize: 30 * scale,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          SizedBox(height: 0.0002 * scale),
                          Text(
                            'By FerryX',
                            style: GoogleFonts.montserrat(
                              color: const Color.fromARGB(255, 80, 194, 184),
                              fontSize: 16 * scale,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 4 * scale),
                    // Right block
                    SizedBox(
                      width: w * 0.35,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'The Future is Here',
                            style: GoogleFonts.montserrat(
                              color: gold,
                              fontSize: 10 * scale,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 6 * scale),
                          Text(
                            'KLAIPĖDA | SMILTYNĖ',
                            style: GoogleFonts.montserrat(
                              color: const Color.fromARGB(255, 247, 228, 131),
                              fontSize: 11 * scale,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 6 * scale),
                          Text(
                            'Ticketing Made Easier with FerryX',
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            style: GoogleFonts.montserrat(
                              color: gold,
                              fontSize: 7 * scale,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _actionTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(color: const Color(0xFFEAEAEA)),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 28, color: const Color(0xFF0E5FE3)),
                const SizedBox(height: 10),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
