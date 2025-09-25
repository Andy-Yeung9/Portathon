class Ticket {
  final String operatorName;           // e.g., FerryX
  final String bookingRef;             // e.g., FX5204
  final String operatorRef;            // e.g., internal ref
  final DateTime departAt;
  final Duration duration;
  final String vehicle;                // "PEDESTRIAN" / "CAR" / etc.
  final List<String> passengers;       // lead + others
  final List<Leg> legs;                // out & return
  final String barcodeData;            // value to encode

  const Ticket({
    required this.operatorName,
    required this.bookingRef,
    required this.operatorRef,
    required this.departAt,
    required this.duration,
    required this.vehicle,
    required this.passengers,
    required this.legs,
    required this.barcodeData,
  });

  factory Ticket.fromJson(Map<String, dynamic> j) => Ticket(
        operatorName: j['operatorName'],
        bookingRef: j['bookingRef'],
        operatorRef: j['operatorRef'],
        departAt: DateTime.parse(j['departAt']),
        duration: Duration(minutes: j['durationMinutes']),
        vehicle: j['vehicle'],
        passengers: List<String>.from(j['passengers'] ?? []),
        legs: (j['legs'] as List<dynamic>)
            .map((e) => Leg.fromJson(e as Map<String, dynamic>))
            .toList(),
        barcodeData: j['barcodeData'],
      );

  Map<String, dynamic> toJson() => {
        'operatorName': operatorName,
        'bookingRef': bookingRef,
        'operatorRef': operatorRef,
        'departAt': departAt.toIso8601String(),
        'durationMinutes': duration.inMinutes,
        'vehicle': vehicle,
        'passengers': passengers,
        'legs': legs.map((e) => e.toJson()).toList(),
        'barcodeData': barcodeData,
      };
}

class Leg {
  final String fromCity;
  final String fromCountry;
  final String toCity;
  final String toCountry;

  const Leg({
    required this.fromCity,
    required this.fromCountry,
    required this.toCity,
    required this.toCountry,
  });

  factory Leg.fromJson(Map<String, dynamic> j) => Leg(
        fromCity: j['fromCity'],
        fromCountry: j['fromCountry'],
        toCity: j['toCity'],
        toCountry: j['toCountry'],
      );

  Map<String, dynamic> toJson() => {
        'fromCity': fromCity,
        'fromCountry': fromCountry,
        'toCity': toCity,
        'toCountry': toCountry,
      };
}
