import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

/// Bluetooth widget to find and connect to the RC car.
/// Displays connection status and paired devices using `flutter_bluetooth_serial`.
/// Intended for use with an ESP32-based RC car.
class CarFinder extends StatefulWidget {
  const CarFinder({super.key});

  @override
  CarFinderState createState() => CarFinderState();
}

class CarFinderState extends State<CarFinder> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  BluetoothConnection? _connection;
  bool _isConnecting = false;

  bool get _isConnected => _connection != null && _connection!.isConnected;

  @override
  void initState() {
    super.initState();
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() => _bluetoothState = state);
    });
  }

  /// Connects to a selected device
  Future<void> _connectToDevice(BluetoothDevice device) async {
    setState(() => _isConnecting = true);

    try {
      final conn = await BluetoothConnection.toAddress(device.address);
      setState(() {
        _connection = conn;
        _isConnecting = false;
      });

      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      setState(() => _isConnecting = false);
      _showErrorDialog("Failed to connect: $e");
    }
  }

  /// Displays error dialog
  void _showErrorDialog(String message) {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) {
        // Military color palette
        const Color khaki = Color(0xFFC3B091);
        const Color armyBrown = Color(0xFF6B5636);

        return AlertDialog(
          backgroundColor: armyBrown,
          title: const Text(
            "Bluetooth Error",
            style: TextStyle(color: khaki, fontWeight: FontWeight.bold),
          ),
          content: Text(
            message,
            style: const TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK", style: TextStyle(color: khaki)),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _connection?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Military color palette
    const Color oliveGreen = Color(0xFF556B2F);
    const Color darkOlive = Color(0xFF3B4723);
    const Color khaki = Color(0xFFC3B091);

    return Scaffold(
      backgroundColor: darkOlive,
      appBar: AppBar(
        title: const Text(
          'Bluetooth Car Finder',
          style: TextStyle(color: khaki),
        ),
        centerTitle: true,
        backgroundColor: oliveGreen,
        iconTheme: const IconThemeData(color: khaki),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bluetooth State: $_bluetoothState',
                style: const TextStyle(
                  color: khaki,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: oliveGreen,
                  foregroundColor: khaki,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _isConnecting
                    ? null
                    : () async {
                        final device =
                            await Navigator.of(context).push<BluetoothDevice?>(
                          MaterialPageRoute(
                            builder: (context) => const SelectBondedDevicePage(),
                          ),
                        );

                        if (device != null) {
                          await _connectToDevice(device);
                        }
                      },
                child: Text(
                  _isConnecting ? 'Connecting...' : 'Connect to RC Car',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                _isConnected ? 'Connected to RC Car' : 'Not connected',
                style: TextStyle(
                  color: _isConnected ? Colors.greenAccent[400] : Colors.redAccent[200],
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Displays bonded Bluetooth devices for selection
class SelectBondedDevicePage extends StatefulWidget {
  const SelectBondedDevicePage({super.key});

  @override
  State<SelectBondedDevicePage> createState() => _SelectBondedDevicePageState();
}

class _SelectBondedDevicePageState extends State<SelectBondedDevicePage> {
  List<BluetoothDevice> _devices = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBondedDevices();
  }

  Future<void> _loadBondedDevices() async {
    try {
      final devices = await FlutterBluetoothSerial.instance.getBondedDevices();
      setState(() {
        _devices = devices;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Military color palette
    const Color oliveGreen = Color(0xFF556B2F);
    const Color darkOlive = Color(0xFF3B4723);
    const Color khaki = Color(0xFFC3B091);
    const Color armyBrown = Color(0xFF6B5636);

    return Scaffold(
      backgroundColor: darkOlive,
      appBar: AppBar(
        title: const Text(
          'Select Bonded Device',
          style: TextStyle(color: khaki),
        ),
        backgroundColor: oliveGreen,
        iconTheme: const IconThemeData(color: khaki),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: khaki))
          : _devices.isEmpty
              ? const Center(
                  child: Text(
                    'No paired devices found.',
                    style: TextStyle(color: khaki, fontSize: 16),
                  ),
                )
              : ListView.builder(
                  itemCount: _devices.length,
                  itemBuilder: (context, index) {
                    final device = _devices[index];
                    return Card(
                      color: armyBrown,
                      margin:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(
                          device.name ?? 'Unknown Device',
                          style: const TextStyle(color: khaki, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          device.address,
                          style: const TextStyle(color: Colors.white70),
                        ),
                        onTap: () => Navigator.of(context).pop(device),
                      ),
                    );
                  },
                ),
    );
  }
}
