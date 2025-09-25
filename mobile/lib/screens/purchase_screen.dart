import 'package:flutter/material.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({Key? key}) : super(key: key);

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  // Form state variables
  DateTime _selectedDate = DateTime.now();
  TripType _tripType = TripType.single;
  PassengerType _passengerType = PassengerType.normal;
  int _quantity = 1;

  // Data structure for pricing (will be replaced with API data later)
  final FerryPricing _pricing = FerryPricing(
    basePrices: {
      PassengerType.normal: 2.00,
      PassengerType.withBicycle: 3.00, // Includes bike fee
      PassengerType.withBabyCarriage: 2.00, // Free for accessibility
    },
    roundTripMultiplier: 1.8,
    vatPercentage: 21.0,
  );

  @override
  Widget build(BuildContext context) {
    final totalPrice = _calculateTotalPrice();
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Purchase Ferry Ticket"),
        centerTitle: true,
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section with improved visual design
            _buildHeaderSection(),
            const SizedBox(height: 28),
            
            // Trip Details Card
            _buildTripDetailsCard(),
            const SizedBox(height: 20),
            
            // Passenger Details Card
            _buildPassengerDetailsCard(),
            const SizedBox(height: 28),
            
            // Total Price Section with enhanced visual appeal
            _buildTotalPriceSection(totalPrice),
            const SizedBox(height: 20),
            
            // Purchase Button with better styling
            _buildPurchaseButton(totalPrice),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue[800]!, Colors.blue[600]!],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue[900]!.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.directions_boat, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  "Klaipėda ↔ Smiltynė Ferry",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Sustainable ferry service across the Curonian Lagoon",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white.withOpacity(0.9),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripDetailsCard() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      shadowColor: Colors.black.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.blue[700], size: 20),
                const SizedBox(width: 8),
                const Text(
                  "Trip Details",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Date Selection
            _buildDateSelector(),
            const SizedBox(height: 20),
            
            // Trip Type Selection
            _buildTripTypeSelector(),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Travel Date",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: _selectDate,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(Icons.calendar_month, color: Colors.blue[700]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTripTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Trip Type",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildTripTypeButton(
                "Single Trip",
                TripType.single,
                Icons.arrow_forward,
                "One way trip",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTripTypeButton(
                "Round Trip",
                TripType.round,
                Icons.swap_horiz,
                "Save 10%",
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTripTypeButton(String label, TripType type, IconData icon, String subtitle) {
    final isSelected = _tripType == type;
    return GestureDetector(
      onTap: () => setState(() => _tripType = type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[50] : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue[700]! : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: Colors.blue[100]!,
              blurRadius: 10,
              offset: const Offset(0, 3),
            )
          ] : [],
        ),
        child: Column(
          children: [
            Icon(icon, 
                color: isSelected ? Colors.blue[700] : Colors.grey[600],
                size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.blue[700] : Colors.grey[700],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 11,
                color: isSelected ? Colors.blue[600] : Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPassengerDetailsCard() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      shadowColor: Colors.black.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person, color: Colors.blue[700], size: 20),
                const SizedBox(width: 8),
                const Text(
                  "Passenger Details",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Passenger Type
            _buildPassengerTypeSelector(),
            const SizedBox(height: 20),
            
            // Quantity Selector
            _buildQuantitySelector(),
          ],
        ),
      ),
    );
  }

  Widget _buildPassengerTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Passenger Type",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Column(
          children: PassengerType.values.map((type) {
            final isSelected = _passengerType == type;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _buildPassengerTypeTile(type, isSelected),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPassengerTypeTile(PassengerType type, bool isSelected) {
    final price = _pricing.basePrices[type]!;
    final description = _getPassengerTypeDescription(type);
    final icon = _getPassengerTypeIcon(type);
    
    return GestureDetector(
      onTap: () => setState(() => _passengerType = type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[50] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue[700]! : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue[100] : Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(icon, 
                  color: isSelected ? Colors.blue[700] : Colors.grey[600],
                  size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getPassengerTypeLabel(type),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.blue[700] : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.blue[600] : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "€${price.toStringAsFixed(2)}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.blue[700] : Colors.green[700],
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Text(
            "Number of Passengers:",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove, color: Colors.red[600]),
                  onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    _quantity.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.green[600]),
                  onPressed: () => setState(() => _quantity++),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalPriceSection(double totalPrice) {
    final basePrice = _pricing.basePrices[_passengerType]! * _quantity;
    final subtotal = _tripType == TripType.round 
        ? basePrice * _pricing.roundTripMultiplier
        : basePrice;
    final vatAmount = subtotal * (_pricing.vatPercentage / 100);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue[50]!, Colors.blue[100]!],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.receipt, color: Color.fromARGB(255, 25, 118, 210)),
              SizedBox(width: 8),
              Text(
                "Price Summary",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          _buildPriceRow("Base fare", basePrice),
          if (_tripType == TripType.round) 
            _buildPriceRow("Round trip discount", basePrice * (1 - _pricing.roundTripMultiplier)),
          
          const SizedBox(height: 8),
          const Divider(color: Color.fromARGB(255, 144, 202, 249)),
          const SizedBox(height: 8),
          
          _buildPriceRow("Subtotal", subtotal),
          _buildPriceRow("VAT (${_pricing.vatPercentage}%)", vatAmount),
          
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Amount:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "€${totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.black87),
          ),
          Text(
            amount >= 0 ? "€${amount.toStringAsFixed(2)}" : "-€${(-amount).toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: amount >= 0 ? Colors.black87 : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseButton(double totalPrice) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _purchaseTicket,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[700],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          shadowColor: Colors.blue[900],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.confirmation_number, size: 22),
            SizedBox(width: 12),
            Text(
              "Purchase Ticket",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue[700]!,
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  double _calculateTotalPrice() {
    double basePrice = _pricing.basePrices[_passengerType]! * _quantity;
    
    // Apply round trip discount
    if (_tripType == TripType.round) {
      basePrice *= _pricing.roundTripMultiplier;
    }
    
    // Include VAT
    return basePrice * (1 + _pricing.vatPercentage / 100);
  }

  void _purchaseTicket() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.confirmation_number, 
                    color: Colors.blue[700], size: 48),
                const SizedBox(height: 16),
                const Text(
                  "Confirm Purchase",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _buildConfirmationRow("Passenger", 
                          _getPassengerTypeLabel(_passengerType)),
                      _buildConfirmationRow("Quantity", _quantity.toString()),
                      _buildConfirmationRow("Trip Type", 
                          _tripType == TripType.single ? "Single" : "Round Trip"),
                      const Divider(),
                      _buildConfirmationRow(
                        "Total", 
                        "€${_calculateTotalPrice().toStringAsFixed(2)}",
                        isTotal: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text("Cancel"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _showSuccessDialog();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text("Confirm"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildConfirmationRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black87 : Colors.grey[700],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.green : Colors.black87,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check_circle, 
                      color: Colors.green[600], size: 48),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Ticket Purchased!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Your ferry ticket has been successfully purchased. You can find it in your Tickets section.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color.fromARGB(255, 97, 97, 97)),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Navigate to tickets screen or home
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600],
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("View Tickets"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper methods for passenger type
  String _getPassengerTypeLabel(PassengerType type) {
    switch (type) {
      case PassengerType.normal:
        return "Standard Passenger";
      case PassengerType.withBicycle:
        return "Passenger with Bicycle";
      case PassengerType.withBabyCarriage:
        return "Passenger with Baby Carriage";
    }
  }

  String _getPassengerTypeDescription(PassengerType type) {
    switch (type) {
      case PassengerType.normal:
        return "Regular passenger fare";
      case PassengerType.withBicycle:
        return "Includes bicycle transportation";
      case PassengerType.withBabyCarriage:
        return "Free baby carriage transportation";
    }
  }

  IconData _getPassengerTypeIcon(PassengerType type) {
    switch (type) {
      case PassengerType.normal:
        return Icons.person;
      case PassengerType.withBicycle:
        return Icons.pedal_bike;
      case PassengerType.withBabyCarriage:
        return Icons.child_care;
    }
  }
}

// Data Structures (will be replaced with API models later)
class FerryPricing {
  final Map<PassengerType, double> basePrices;
  final double roundTripMultiplier;
  final double vatPercentage;

  FerryPricing({
    required this.basePrices,
    required this.roundTripMultiplier,
    required this.vatPercentage,
  });
}

// Enums for better type safety
enum TripType { single, round }
enum PassengerType { normal, withBicycle, withBabyCarriage }