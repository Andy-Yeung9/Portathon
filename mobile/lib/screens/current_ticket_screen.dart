import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/models/ticket.dart';

class CurrentTicketScreen extends StatelessWidget {
  const CurrentTicketScreen({super.key, required this.ticket});
  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    final pageBg = const Color(0xFFE6EAE6);

    return Scaffold(
      backgroundColor: pageBg,
      appBar: AppBar(
        title: const Text('My Ticket'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: _WhiteCoupon(ticket: ticket),
          ),
        ),
      ),
    );
  }
}

class _WhiteCoupon extends StatelessWidget {
  const _WhiteCoupon({required this.ticket});
  final Ticket ticket;

  String _formatDate(DateTime dt) {
    const months = [
      'JAN','FEB','MAR','APR','MAY','JUN',
      'JUL','AUG','SEP','OCT','NOV','DEC'
    ];
    final hh = dt.hour.toString().padLeft(2, '0');
    final mm = dt.minute.toString().padLeft(2, '0');
    final dd = dt.day.toString().padLeft(2, '0');
    return '$dd ${months[dt.month - 1]} ${dt.year}, $hh:$mm';
  }

  @override
  Widget build(BuildContext context) {
    final brandBlue = Colors.blue[900]!;
    const pageBg = Color(0xFFE6EAE6);

    final labelStyle = GoogleFonts.montserrat(
      color: Colors.black54,
      fontSize: 8.5,
      letterSpacing: 0.6,
      fontWeight: FontWeight.w700,
    );
    final valueStyle = GoogleFonts.montserrat(
      color: Colors.black87,
      fontSize: 10.5,
      fontWeight: FontWeight.w600,
    );

    final from = ticket.legs.isNotEmpty
        ? ticket.legs.first.fromCity.toUpperCase()
        : 'KLAIPĖDA';
    final to = ticket.legs.isNotEmpty
        ? ticket.legs.first.toCity.toUpperCase()
        : 'SMILTYNĖ';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // ===== TOP SECTION: route + date/ref (now inside coupon)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    '$from  ↔  $to',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      color: brandBlue,
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _formatDate(ticket.departAt),
                        style: GoogleFonts.montserrat(
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.5,
                        ),
                      ),
                    ),
                    Text(
                      'REF: ${ticket.bookingRef}',
                      style: GoogleFonts.montserrat(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ===== MAIN INFO (company & details)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Brand row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 28,
                      width: 28,
                      decoration: const BoxDecoration(
                        color: Colors.black12,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'FX',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        ticket.operatorName,
                        style: GoogleFonts.montserrat(
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  ticket.operatorRef, // e.g., Company code 14085526
                  style: GoogleFonts.montserrat(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 14),

                // Two rows of pairs
                Row(
                  children: [
                    Expanded(
                      child: _InfoBlock(
                        label: 'LOCATION',
                        value: 'Ferry',
                        labelStyle: labelStyle,
                        valueStyle: valueStyle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _InfoBlock(
                        label: 'ITEM',
                        value:
                            ticket.vehicle == 'PASSENGER' ? 'Passenger' : ticket.vehicle,
                        labelStyle: labelStyle,
                        valueStyle: valueStyle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _InfoBlock(
                        label: 'PRICE',
                        value: '1.70',
                        labelStyle: labelStyle,
                        valueStyle: valueStyle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _InfoBlock(
                        label: 'TICKET NO.',
                        value: ticket.bookingRef,
                        labelStyle: labelStyle,
                        valueStyle: valueStyle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _InfoBlock(
                  label: 'SELF-SERVICE CHECKOUT',
                  value: 'SMILTYNE-KASA-5',
                  labelStyle: labelStyle,
                  valueStyle: valueStyle,
                ),
                const SizedBox(height: 10),
                _InfoBlock(
                  label: 'PASSAGE THROUGH TURNSTILES NO.',
                  value: '2, 3, 4, 5, 6, 7',
                  labelStyle: labelStyle,
                  valueStyle: valueStyle,
                ),
              ],
            ),
          ),

          // ===== Perforation with side notches
          SizedBox(
            height: 24,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: _DottedDividerColored(color: Color(0xFFCBD5DF)),
                  ),
                ),
                Positioned(
                  left: -12,
                  top: 0,
                  bottom: 0,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: pageBg,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: -12,
                  top: 0,
                  bottom: 0,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: pageBg,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ===== Bottom: barcode + notes + download
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE4E8EE)),
                  ),
                  child: const _BarcodePlaceholder(),
                ),
                const SizedBox(height: 10),
                Text(
                  'The ticket is valid only on the day of purchase in both directions. '
                  'A return trip with the same ticket is possible the next day.',
                  style: GoogleFonts.montserrat(
                    color: Colors.black87,
                    fontSize: 8,
                    height: 1.36,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Important: Please note that the ticket should be scanned during onboarding on the ferry in BOTH directions',
                  style: GoogleFonts.montserrat(
                    color: Colors.black87,
                    fontSize: 8,
                    height: 1.36,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 44,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Downloading ticket...')),
                      );
                    },
                    icon: const Icon(Icons.download),
                    label: const Text('Download Ticket'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: brandBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoBlock extends StatelessWidget {
  const _InfoBlock({
    required this.label,
    required this.value,
    required this.labelStyle,
    required this.valueStyle,
  });

  final String label;
  final String value;
  final TextStyle labelStyle;
  final TextStyle valueStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle),
        const SizedBox(height: 6),
        Text(value, style: valueStyle),
      ],
    );
  }
}

class _DottedDividerColored extends StatelessWidget {
  const _DottedDividerColored({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DotsPainter(color),
      size: const Size(double.infinity, 1),
    );
  }
}

class _DotsPainter extends CustomPainter {
  _DotsPainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const dashWidth = 6.0;
    const dashSpace = 5.0;
    double x = 0;
    const y = 0.0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, y), Offset(x + dashWidth, y), paint);
      x += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BarcodePlaceholder extends StatelessWidget {
  const _BarcodePlaceholder();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BarcodePainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _BarcodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = Colors.white;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(12)),
      bg,
    );

    final bar = Paint()..color = Colors.black87;
    final left = 16.0;
    final right = size.width - 16.0;
    const top = 12.0;
    final bottom = size.height - 12.0;

    final widths = [1.6, 2.4, 1.2, 3.2, 1.8, 1.4, 2.0, 2.8, 1.5, 2.6, 1.3, 3.0];
    double x = left;
    int i = 0;
    while (x < right) {
      final w = widths[i % widths.length];
      canvas.drawRect(Rect.fromLTWH(x, top, w, bottom - top), bar);
      x += w + 1.4;
      i++;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
