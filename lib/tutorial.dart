import 'package:flutter/material.dart';
import 'package:rc_tank_app/homescreen.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  int currentPage = 0;

  // Tutorial pages
  final List<Map<String, String>> tutorialPages = [
    {
      'title': 'Welcome',
      'content':
          'This app allows you to control your Bluetooth robot. Use the joystick controls to move and the Bluetooth button to connect.',
    },
    {
      'title': 'Bluetooth Button',
      'content':
          'Tap the Bluetooth button on the top right of the Home Screen to start scanning for nearby devices. Connect to your robot before using the controls.',
    },
    {
      'title': 'Left Joystick',
      'content':
          'The left joystick controls movement direction — push forward to move ahead, pull back to reverse, and move left or right to turn.',
    },
    {
      'title': 'Fire Button',
      'content':
          'The Fire Button allows you to activate the robot\'s firing mechanism. Press and hold to fire, release to stop.',
    },
    {
      'title': 'You’re Ready!',
      'content':
          'You can now return to the Home Screen and start controlling your robot. Enjoy experimenting with the controls!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final page = tutorialPages[currentPage];

    // Military color palette
    const Color oliveGreen = Color(0xFF556B2F);
    const Color darkOlive = Color(0xFF3B4723);
    const Color khaki = Color(0xFFC3B091);
    const Color armyBrown = Color(0xFF6B5636);

    return Scaffold(
      backgroundColor: darkOlive,
      appBar: AppBar(
        backgroundColor: oliveGreen,
        centerTitle: true,
        title: const Text(
          'Tutorial',
          style: TextStyle(color: khaki),
        ),
        iconTheme: const IconThemeData(color: khaki),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            tooltip: 'Go to Home',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.08,
          vertical: size.height * 0.05,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Page content
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    page['title']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: khaki,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Text(
                    page['content']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Navigation buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        currentPage > 0 ? armyBrown : Colors.grey.shade700,
                    foregroundColor: khaki,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: currentPage > 0
                      ? () {
                          setState(() {
                            currentPage--;
                          });
                        }
                      : null,
                  child: const Text(
                    'Back',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                // Next / Finish button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: oliveGreen,
                    foregroundColor: khaki,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (currentPage < tutorialPages.length - 1) {
                      setState(() {
                        currentPage++;
                      });
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HomeScreen(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    currentPage == tutorialPages.length - 1
                        ? 'Finish'
                        : 'Next',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
