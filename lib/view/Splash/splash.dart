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
      const Duration(seconds: 4),
          () {
        Navigator.of(context).pushReplacementNamed('/man');
      },
    );

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 2),
            decoration: const BoxDecoration(
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

          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            builder: (context, value, child) {
              return Opacity(
                opacity: 0.05,
                child: Transform.scale(
                  scale: value,
                  child: child,
                ),
              );
            },
            child: Container(
              height: h * 0.4328,
              width: w * 0.8658,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/message.png'),
                ),
              ),
              alignment: Alignment.center,
            ),
          ),

          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut,
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.scale(
                  scale: value,
                  child: child,
                ),
              );
            },
            child: Text(
              'Textit',
              textAlign: TextAlign.center,
              style: GoogleFonts.courgette(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: w * 0.16,
                  height: h * -0.001,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
