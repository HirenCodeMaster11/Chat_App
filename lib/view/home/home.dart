import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/services/google_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          GestureDetector(
            onTap: () async {
              await AuthService.authService.signOut();
              await GoogleAuthService.googleAuthService.signOutFromGoogle();
              User? user = AuthService.authService.getCurrentUser();
              if(user == null)
                {
                  Get.offAndToNamed('/signIn');
                }
            },
            child: Icon(Icons.logout),
          ),

        ],
      ),
    );
  }
}
