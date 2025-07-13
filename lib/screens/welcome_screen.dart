import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/image/logo.png",
              height: 150,
              color: Colors.black,
            ),
            Center(
              child: Text(
                "Study Tracker",
                style: TextStyle(fontFamily: "Oswald", fontSize: 60),
              ),
            ),
            Text(
              "Track. Study. Succeed.",
              style: TextStyle(fontSize: 20, fontFamily: "Oswald"),
            ),
            SizedBox(height: 300),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.black, width: 3),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/AuthScreen');
              },

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Get Started",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontFamily: "Oswald",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
