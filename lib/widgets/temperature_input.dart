import 'package:flutter/material.dart';

class TemperatureInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isCelsiusToFahrenheit;
  final ValueChanged<bool> onDirectionChanged;
  final VoidCallback onConvert;
  final String result;

  const TemperatureInput({
    super.key,
    required this.controller,
    required this.isCelsiusToFahrenheit,
    required this.onDirectionChanged,
    required this.onConvert,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isError = result.contains('valid');

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [BoxShadow(
                color: colorScheme.shadow.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )],
            ),
            constraints: BoxConstraints(
              maxWidth: constraints.maxWidth,
              minWidth: constraints.minWidth,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: controller,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                  decoration: InputDecoration(
                    labelText: isCelsiusToFahrenheit ? 'Celsius Temperature' : 'Fahrenheit Temperature',
                    helperText: 'Enter a numeric value',
                    errorText: isError ? 'Please enter a valid number' : null,
                    prefixIcon: Icon(
                      Icons.thermostat,
                      color: isError ? colorScheme.error : colorScheme.primary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: colorScheme.outline),
                    ),
                    filled: true,
                    fillColor: colorScheme.surface,
                  ),
                  onSubmitted: (_) => onConvert(),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: ToggleButtons(
                    isSelected: [!isCelsiusToFahrenheit, isCelsiusToFahrenheit],
                    onPressed: (index) => onDirectionChanged(index == 1),
                    constraints: BoxConstraints(
                      minHeight: 40.0,
                      minWidth: (constraints.maxWidth - 96) / 2, // Adjusted width calculation
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                    selectedBorderColor: colorScheme.primary,
                    selectedColor: colorScheme.onPrimary,
                    fillColor: colorScheme.primary,
                    color: colorScheme.onSurfaceVariant,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0), // Reduced padding
                        child: Text('°F to °C',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0), // Reduced padding
                        child: Text('°C to °F',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: onConvert,
                    icon: const Icon(Icons.calculate),
                    label: const Text('Convert'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
                if (result.isNotEmpty) ...[  
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: isError ? colorScheme.errorContainer : colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isError ? Icons.error_outline : Icons.check_circle_outline,
                          color: isError ? colorScheme.error : colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            result,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: isError ? colorScheme.error : colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}