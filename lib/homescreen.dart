import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:rc_tank_app/bluetooth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Military color palette (const)
    const Color militaryGreen = Color(0xFF556B2F);
    const Color khaki = Color(0xFFF0E68C);
    const Color darkBrown = Color(0xFF4B3621);
    const Color oliveDrab = Color(0xFF6B8E23);

    // translucent oliveDrab at 20% opacity expressed as ARGB:
    // 0x33 is ~20% alpha (0x33 == 51 decimal, 51/255 ≈ 0.2)
    const Color oliveDrab20 = Color(0x336B8E23);

    return Scaffold(
      backgroundColor: khaki,
      appBar: AppBar(
        title: const Text('Home Screen'),
        backgroundColor: militaryGreen,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Left Joystick
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: oliveDrab20,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: militaryGreen.withAlpha(200), width: 2),
                    ),
                    child: Joystick(
                      mode: JoystickMode.all,
                      stick: JoystickStick(),
                      listener: (details) {
                        // Handle movement control here
                      },
                    ),
                  ),

                  // Fire Button
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle turret firing here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkBrown,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Fire!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Bluetooth Button
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  CarFinder(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: militaryGreen,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Bluetooth',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Return to Start Screen Button
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: oliveDrab,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Return to Start',
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
