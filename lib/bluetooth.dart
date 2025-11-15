import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

/// Bluetooth widget to find and connect to the RC car, class is called CarFinder.
/// Displays connection status and paired devices using `flutter_blue_plus`.
/// Intended for use with an ESP32-based RC car.
/// Uses a military color palette for styling.


class CarFinder extends StatefulWidget {
  const CarFinder({super.key});

  @override
  State<CarFinder> createState() => _CarFinderState();
}

class _CarFinderState extends State<CarFinder> {
  bool isScanning = false;

  // Begin BLE scan
  Future<void> startScan() async {
    setState(() => isScanning = true);

    FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));

    FlutterBluePlus.isScanning.listen((scanning) {
      setState(() => isScanning = scanning);
    });
  }

  // Placeholder Bluetooth action
  void bluetoothAction() {
    debugPrint("Bluetooth action triggered");
  }

  @override
  Widget build(BuildContext context) {
    final adapterState = FlutterBluePlus.adapterStateNow;

    // Military color palette (same as HomeScreen)
    const Color militaryGreen = Color(0xFF556B2F);
    const Color khaki = Color(0xFFF0E68C);
    const Color darkBrown = Color(0xFF4B3621);
    const Color oliveDrab = Color(0xFF6B8E23);
    const Color oliveDrab20 = Color(0x336B8E23);

    return Scaffold(
      backgroundColor: khaki,
      appBar: AppBar(
        title: const Text("Bluetooth"),
        backgroundColor: militaryGreen,
        foregroundColor: Colors.white,
      ),
      body: adapterState != BluetoothAdapterState.on
          ? const Center(
              child: Text(
                "Please turn on Bluetooth.",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // Scan button
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isScanning ? null : startScan,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: militaryGreen,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        isScanning ? "Scanning..." : "Scan for Devices",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Bluetooth action button
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: bluetoothAction,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkBrown,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Bluetooth Function",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Device list container (matches UI style)
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: oliveDrab20,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: militaryGreen.withAlpha(200),
                          width: 2,
                        ),
                      ),
                      child: StreamBuilder<List<ScanResult>>(
                        stream: FlutterBluePlus.scanResults,
                        initialData: const [],
                        builder: (context, snapshot) {
                          final results = snapshot.data ?? [];

                          if (results.isEmpty) {
                            return const Center(
                              child: Text(
                                "No devices found.",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }

                          return ListView.builder(
                            itemCount: results.length,
                            itemBuilder: (context, index) {
                              final r = results[index];
                              final device = r.device;

                              return ListTile(
                                title: Text(
                                  device.platformName.isNotEmpty
                                      ? device.platformName
                                      : "Unknown Device",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(device.remoteId.toString()),
                                trailing: Icon(Icons.bluetooth,
                                    color: oliveDrab),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Return button (same as HomeScreen layout)
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: oliveDrab,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Return Home",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
