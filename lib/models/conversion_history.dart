class ConversionRecord {
  final String fromValue;
  final String toValue;
  final bool isCelsiusToFahrenheit;
  final DateTime timestamp;

  ConversionRecord({
    required this.fromValue,
    required this.toValue,
    required this.isCelsiusToFahrenheit,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  String get formattedConversion {
    final direction = isCelsiusToFahrenheit ? 'C to F' : 'F to C';
    return '$direction: $fromValue => $toValue';
  }

  String get formattedTimestamp {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }
}