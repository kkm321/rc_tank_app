import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

/// Bluetooth widget to find and connect to the RC car, class is called CarFinder.
/// Displays connection status and paired devices using `flutter_blue_plus`.
/// Intended for use with an ESP32-based RC car.
/// Uses a military color palette for styling.
class CarFinder extends StatelessWidget {
  final FlutterBluePlus flutterBlue = FlutterBluePlus as FlutterBluePlus;

   CarFinder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RC Car Bluetooth Connection'),
        backgroundColor: const Color(0xFF2E8B57), // Military green
      ),
      body: StreamBuilder<BluetoothAdapterState>(
        stream: FlutterBluePlus.adapterState,
        initialData: BluetoothAdapterState.unknown,
        builder: (c, snapshot) {
          final state = snapshot.data;
          if (state == BluetoothAdapterState.on) {
            return StreamBuilder<List<BluetoothDevice>>(
              stream: FlutterBluePlus.connectedDevices.asStream(),
              initialData: const [],
              builder: (c, snapshot) {
                final devices = snapshot.data!;
                return ListView.builder(
                  itemCount: devices.length,
                  itemBuilder: (c, index) {
                    final device = devices[index];
                    return ListTile(
                      title: Text(device.platformName.isNotEmpty ? device.platformName : 'Unknown Device'),
                      subtitle: Text(device.remoteId.toString()),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF556B2F), // Dark olive green
                        ),
                        child: const Text('Disconnect'),
                        onPressed: () async {
                          await device.disconnect();
                        },
                      ),
                    );
                  },
                );
              },
            );
          }
          return Center(
            child: Text(
              state == BluetoothAdapterState.off
                  ? 'Bluetooth is Off. Please enable Bluetooth.'
                  : 'Bluetooth State: $state',
              style: const TextStyle(fontSize: 18, color: Color(0xFF8B0000)), // Dark red
            ),
          );
        },
      ),
    );
  }
}
