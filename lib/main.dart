import 'package:chat_app/view/Get%20start/start.dart';
import 'package:chat_app/view/Setting%20Page/setting.dart';
import 'package:chat_app/view/Splash/splash.dart';
import 'package:chat_app/view/auth/auth_manager.dart';
import 'package:chat_app/view/auth/sign_in.dart';
import 'package:chat_app/view/auth/sign_up.dart';
import 'package:chat_app/view/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';
import 'view/Chat Page/chat.dart';

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
        GetPage(name: '/', page: () => SplashScreen(),),
        GetPage(name: '/man', page: () => AuthManager(),),
        GetPage(name: '/start', page: () => Start(),),
        GetPage(name: '/signIn', page: () => SignIn(),),
        GetPage(name: '/signUp', page: () => SignUp(),),
        GetPage(name: '/home', page: () => HomePage(),),
        GetPage(name: '/chat', page: () => ChatPage(),),
        GetPage(name: '/set', page: () => SettingPage(),),
      ],
    );
  }
}
