import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    Timer(
      Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacementNamed('/start');
      },
    );
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff0c0926),
                  Color(0xff35467e),
                  Color(0xff171d33),
                  Color(0xff5669aa),
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
          Opacity(
            opacity: 0.05,
            // Set your desired opacity (0.0 - fully transparent, 1.0 - fully opaque)
            child: Container(
              height: h * 0.4328,
              width: w * 0.8658,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/message.png'),
                ),
              ),
              alignment: Alignment.center,
            ),
          ),
          Text(
            'Textit',
            textAlign: TextAlign.center,
            style: GoogleFonts.courgette(
              // Change to your desired font
              textStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: w * 0.16,
                height: h * -0.001,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
