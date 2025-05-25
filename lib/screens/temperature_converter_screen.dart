import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/conversion_history.dart';
import '../utils/temperature_calculator.dart';
import '../widgets/temperature_input.dart';
import '../widgets/conversion_history_list.dart';

class TemperatureConverterScreen extends StatefulWidget {
  const TemperatureConverterScreen({super.key});

  @override
  State<TemperatureConverterScreen> createState() => _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState extends State<TemperatureConverterScreen> {
  final TextEditingController _temperatureController = TextEditingController();
  bool _isCelsiusToFahrenheit = true;
  String _result = '';
  final List<ConversionRecord> _conversionHistory = [];
  static const String _historyKey = 'conversion_history';

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getStringList(_historyKey) ?? [];
    setState(() {
      _conversionHistory.clear();
      for (final recordJson in historyJson) {
        final map = json.decode(recordJson);
        _conversionHistory.add(ConversionRecord(
          fromValue: map['fromValue'],
          toValue: map['toValue'],
          isCelsiusToFahrenheit: map['isCelsiusToFahrenheit'],
          timestamp: DateTime.parse(map['timestamp']),
        ));
      }
    });
  }

  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = _conversionHistory.map((record) => json.encode({
      'fromValue': record.fromValue,
      'toValue': record.toValue,
      'isCelsiusToFahrenheit': record.isCelsiusToFahrenheit,
      'timestamp': record.timestamp.toIso8601String(),
    })).toList();
    await prefs.setStringList(_historyKey, historyJson);
  }

  void _convertTemperature() {
    // Trim whitespace from input
    final String input = _temperatureController.text.trim();
    if (input.isEmpty) {
      setState(() {
        _result = 'Please enter a temperature value';
      });
      return;
    }

    final double? temperature = double.tryParse(input);
    if (temperature == null) {
      setState(() {
        _result = 'Please enter a valid number';
      });
      return;
    }

    setState(() {
      if (_isCelsiusToFahrenheit) {
        final double fahrenheit = TemperatureCalculator.celsiusToFahrenheit(temperature);
        _result = TemperatureCalculator.getConversionResult(temperature, true);
        _addToHistory(temperature.toString(), fahrenheit.toStringAsFixed(1), true);
      } else {
        final double celsius = TemperatureCalculator.fahrenheitToCelsius(temperature);
        _result = TemperatureCalculator.getConversionResult(temperature, false);
        _addToHistory(temperature.toString(), celsius.toStringAsFixed(1), false);
      }
    });
  }

  void _addToHistory(String fromValue, String toValue, bool isCelsiusToFahrenheit) {
    setState(() {
      _conversionHistory.insert(
        0,
        ConversionRecord(
          fromValue: fromValue,
          toValue: toValue,
          isCelsiusToFahrenheit: isCelsiusToFahrenheit,
        ),
      );
    });
    _saveHistory(); // Save after adding new record
  }

  void _clearHistory() {
    setState(() {
      _conversionHistory.clear();
    });
    _saveHistory(); // Save after clearing
  }

  @override
  void dispose() {
    _temperatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.thermostat,
              color: colorScheme.onPrimary,
            ),
            const SizedBox(width: 8),
            Text(
              'Temperature Converter',
              style: TextStyle(color: colorScheme.onPrimary),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.primary.withOpacity(0.1),
              colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: OrientationBuilder(
            builder: (context, orientation) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: orientation == Orientation.portrait
                    ? Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TemperatureInput(
                              controller: _temperatureController,
                              isCelsiusToFahrenheit: _isCelsiusToFahrenheit,
                              onDirectionChanged: (value) {
                                setState(() {
                                  _isCelsiusToFahrenheit = value;
                                  _result = '';
                                });
                              },
                              onConvert: _convertTemperature,
                              result: _result,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            flex: 3,
                            child: ConversionHistoryList(
                              history: _conversionHistory,
                              onClear: _clearHistory,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: TemperatureInput(
                              controller: _temperatureController,
                              isCelsiusToFahrenheit: _isCelsiusToFahrenheit,
                              onDirectionChanged: (value) {
                                setState(() {
                                  _isCelsiusToFahrenheit = value;
                                  _result = '';
                                });
                              },
                              onConvert: _convertTemperature,
                              result: _result,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ConversionHistoryList(
                              history: _conversionHistory,
                              onClear: _clearHistory,
                            ),
                          ),
                        ],
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}