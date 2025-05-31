# Temperature Converter App

A Flutter application that allows users to convert temperatures between Celsius and Fahrenheit with a modern, user-friendly interface and conversion history tracking.

## Features

- **Temperature Conversion**
  - Convert between Celsius and Fahrenheit
  - Real-time input validation
  - Clear visual feedback for conversion results
  - Toggle between °C to °F and °F to °C conversions

- **Conversion History**
  - Automatically saves conversion history
  - Displays timestamp for each conversion
  - Persists history between app sessions
  - Scrollable history view

- **User Interface**
  - Modern Material Design
  - Responsive layout
  - Error handling with visual feedback
  - Smooth animations and transitions

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio/VS Code with Flutter plugins

### Installation

1. Clone the repository:
```bash
git clone https://github.com/Makito042/m.okoye_individualAssignment1.git
```

2. Navigate to the project directory:
```bash
cd m_okoye_individual_assignment1
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## Usage

1. Enter a temperature value in the input field
2. Select the conversion direction (°C to °F or °F to °C) using the toggle
3. Press the Convert button or hit enter
4. View the conversion result in the result display area
5. Check the conversion history below for previous conversions

## Project Structure

```
lib/
├── main.dart           # App entry point
├── models/             # Data models
├── screens/            # App screens
├── utils/             # Utility functions
└── widgets/           # Reusable widgets
```

## Dependencies

- `shared_preferences`: For persisting conversion history
- Flutter's Material Design widgets

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
