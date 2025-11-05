import 'package:flutter/material.dart';
import 'package:rc_tank_app/tutorial.dart';
import 'package:rc_tank_app/homescreen.dart' as home;

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

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
          'Welcome',
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
              const Text(
                'Welcome to the RC Car Controller App!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: khaki,
                ),
              ),
              const SizedBox(height: 40),

              // Tutorial Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: armyBrown,
                    foregroundColor: khaki,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TutorialScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Tutorial',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Home Screen Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: oliveGreen,
                    foregroundColor: khaki,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const home.HomeScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Home Screen',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
