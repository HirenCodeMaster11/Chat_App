import 'package:chat_app/view/Get%20start/start.dart';
import 'package:chat_app/view/auth/auth_manager.dart';
import 'package:chat_app/view/auth/sign_in.dart';
import 'package:chat_app/view/auth/sign_up.dart';
import 'package:chat_app/view/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        // GetPage(name: '/', page: () => Start(),),
        GetPage(name: '/', page: () => AuthManager(),),
        GetPage(name: '/signIn', page: () => SignIn(),),
        GetPage(name: '/signUp', page: () => SignUp(),),
        GetPage(name: '/home', page: () => HomePage(),),
      ],
    );
  }
}
