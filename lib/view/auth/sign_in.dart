import 'package:animate_do/animate_do.dart';
import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/modal/user.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/services/google_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/cloud_fireStore_service.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key}); // Removed const because of formKey
  final formKey = GlobalKey<FormState>(); // Form key for validation

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    var controller = Get.put(AuthController());

    return Scaffold(
      body: Stack(
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
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: SingleChildScrollView(
              child: Form( // Wrapping form
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: h * 0.12),
                    FadeInUp(
                      duration: const Duration(seconds: 1),
                      child: Text(
                        'Sign in to Chatbox',
                        style: TextStyle(
                            fontSize: w * 0.05,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(height: h * 0.018),
                    FadeInUp(
                      duration: const Duration(seconds: 1),
                      child: Text(
                        'Welcome back! Sign in using your social account or email to continue',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: w * 0.036, color: Colors.grey.shade500),
                      ),
                    ),
                    SizedBox(height: h * 0.052),
                    FadeInLeft(
                      duration: Duration(seconds: 1),
                      child: TextFormField(
                        controller: controller.txtEmail,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail, color: Colors.white),
                          labelText: 'Your email',
                          labelStyle: TextStyle(
                              fontSize: w * 0.038,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Colors.white, width: 2)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!GetUtils.isEmail(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: h * 0.018),
                    Obx(
                          () => FadeInLeft(
                        duration: Duration(seconds: 1),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: controller.txtPassword,
                          obscureText: controller.passwordVisible.value,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock, color: Colors.white),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.passwordVisible.value =
                                !controller.passwordVisible.value;
                              },
                              icon: (controller.passwordVisible.value)
                                  ? Icon(Icons.visibility_off,
                                  color: Colors.white)
                                  : Icon(Icons.visibility, color: Colors.white),
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                fontSize: w * 0.038,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                              BorderSide(color: Colors.white, width: 2),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 8) {
                              return 'Password must be at least 8 characters long';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.05),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'OR',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.04),
                    GestureDetector(
                      onTap: () async {
                        try {
                          await GoogleAuthService.googleAuthService
                              .signInWithGoogle();
                          User? currentUser =
                          AuthService.authService.getCurrentUser();

                          if (currentUser != null) {
                            UserModal user = UserModal(
                              isOnline: true,
                              isTyping: true,
                              lastSeen: Timestamp.now(),
                              email: currentUser.email!,
                              name: currentUser.displayName ?? 'No Name',
                              phone: currentUser.phoneNumber ?? 'No Phone',
                              token: '----',
                              image: currentUser.photoURL ??
                                  'https://www.pngkit.com/png/detail/25-258694_cool-avatar-transparent-image-cool-boy-avatar.png',
                            );

                            await CloudFireStoreService.cloudFireStoreService
                                .insertUserIntoFireStore(user);

                            Get.offAndToNamed('/home');
                          }
                        } catch (e) {
                          print('Google Sign-In failed: $e');
                          Get.snackbar(
                            'SignIn failed!',
                            'Google Sign-In failed. Please try again.',
                            backgroundColor: Colors.grey[900],
                            colorText: Colors.white,
                            snackPosition: SnackPosition.TOP,
                            borderRadius: 8,
                            margin: EdgeInsets.all(16),
                            duration: Duration(seconds: 3),
                            icon: Icon(Icons.warning, color: Colors.yellow),
                          );
                        }
                      },
                      child: FadeInDown(
                        duration: Duration(seconds: 1),
                        child: Container(
                          height: h * 0.071,
                          width: w * 0.1426,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff464d67),
                          ),
                          alignment: Alignment.center,
                          child: Container(
                            height: h * 0.048,
                            width: w * 0.096,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/signIn logo/google.png'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.02),
                    FadeInDown(
                      duration: Duration(seconds: 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.toNamed('/signUp');
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: h * 0.02),
                    GestureDetector(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          String res = await AuthService.authService
                              .signInAccountWithEmailAndPassword(
                              controller.txtEmail.text,
                              controller.txtPassword.text);

                          User? user = AuthService.authService.getCurrentUser();
                          print(user);
                          if (user != null && res == "Success") {
                            Get.offAndToNamed('/home');
                          } else {
                            Get.snackbar(
                              'SignIn failed!',
                              res,
                              backgroundColor: Colors.grey[900],
                              colorText: Colors.white,
                              snackPosition: SnackPosition.TOP,
                              borderRadius: 8,
                              margin: EdgeInsets.all(16),
                              duration: Duration(seconds: 3),
                              icon: Icon(Icons.warning, color: Colors.yellow),
                            );
                          }
                        }
                      },
                      child: FadeInDown(
                        duration: Duration(seconds: 1),
                        child: Container(
                          height: h * 0.064,
                          decoration: BoxDecoration(
                            color: Color(0xff7b829c),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: w * 0.047,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
