# flutter_application_1

A simple Flutter app to control an RC tank over Bluetooth (ESP32).

This repository is open source and released under a strong copyleft license. Any distributed modifications or derivative works must be made available under the same license.

## Quick Start

Prerequisites
- Flutter SDK (https://docs.flutter.dev/get-started/install)
- A physical device (Android or iOS) with Bluetooth — Bluetooth functionality requires testing on real hardware
- An ESP32 running compatible firmware (BLE GATT or Classic SPP) that exposes commands for movement and actuators

Run locally
```bash
flutter pub get
flutter run
```

Build release
```bash
flutter build apk   # Android
flutter build ios   # iOS (requires macOS & Xcode)
```

Platform notes
- Android: ensure Bluetooth permissions and location permissions are declared (manifest) and granted at runtime.
- iOS: add NSBluetoothAlwaysUsageDescription / NSBluetoothPeripheralUsageDescription to Info.plist.
- Ensure the ESP32 is powered and advertising/paired before attempting to connect.

Usage
- Pair/connect to the ESP32 device from the app.
- Use the on-screen controls to drive the tank (forward/backward, left/right) and operate any turret or actuator controls exposed by the firmware.
- See the firmware docs for command formats and expected GATT characteristics or SPP commands.

Tests & formatting
```bash
flutter test
flutter format .
```

Project structure
- lib/ — application source
- test/ — unit/widget tests
- pubspec.yaml — dependencies and metadata

Contributing
By contributing you agree your contributions will be licensed under the same license as this repository. Please:
- Fork the repo
- Create a topic branch
- Open a pull request with a clear description and tests (when applicable)

License
This project is licensed under the GNU General Public License v3.0 (GPL-3.0). Any distributed modifications or derivative works must also be licensed under GPL-3.0. See the LICENSE file for full terms.
