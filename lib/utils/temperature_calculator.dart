class TemperatureCalculator {
  static double celsiusToFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }

  static double fahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32) * 5 / 9;
  }

  static String formatTemperature(double temperature) {
    return temperature.toStringAsFixed(2);
  }

  static String getConversionResult(double input, bool isCelsiusToFahrenheit) {
    final inputStr = formatTemperature(input);
    final result = isCelsiusToFahrenheit
        ? formatTemperature(celsiusToFahrenheit(input))
        : formatTemperature(fahrenheitToCelsius(input));
    final fromUnit = isCelsiusToFahrenheit ? '°C' : '°F';
    final toUnit = isCelsiusToFahrenheit ? '°F' : '°C';
    
    return '$inputStr$fromUnit = $result$toUnit';
  }
}