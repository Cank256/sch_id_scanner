
# School ID Scanner

The School ID Scanner is a Flutter application designed to scan QR codes and process embedded information, particularly for identifying and tracking school IDs. The application uses the Flutter Barcode Scanner to read QR codes and Shared Preferences for data storage and management.

## Features

- **QR Code Scanning**: Scan QR codes to retrieve embedded information.
- **ID Recognition**: Extract and process ID information from the scanned QR codes.
- **Usage Limit**: Limits the number of scans for each ID to prevent excessive use.
- **Error Handling**: Provides feedback for unrecognized QR codes or other scanning errors.
- **Data Reset**: Resets the count of scans daily.

## Installation

To run the School ID Scanner on your device, follow these steps:

1. Clone this repository to your local machine.
   ```
   git clone https://github.com/Cank256/sch_id_scanner.git
   ```
2. Navigate to the project directory.
   ```
   cd sch_id_scanner
   ```
3. Run the following command to get all the dependencies.
   ```
   flutter pub get
   ```
4. Connect your device or open your emulator.
5. Execute the following command to run the app.
   ```
   flutter run
   ```

## Usage

1. Launch the application on your device.
2. Grant camera permissions to the app if prompted.
3. Press the 'Scan QR Code' button to open the scanner interface.
4. Align a QR code within the frame to scan.
5. View the scanned data and processing results on the screen.

## Dependencies

- `flutter_barcode_scanner`: For QR code scanning capabilities.
- `shared_preferences`: For local storage management.
- `intl`: For formatting and parsing dates.
- `flutter_smart_dialog`: For enhanced dialog presentation.
- `http`: For HTTP requests (if interacting with external services).

## Contributing

Contributions are welcome. Please feel free to contribute by submitting a pull request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
