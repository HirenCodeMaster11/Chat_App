import 'package:animate_do/animate_do.dart';
import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/services/cloud_fireStore_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modal/user.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: h * 0.04,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: w * 0.054,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: h * 0.08,
                  ),
                  FadeInUp(
                    duration: Duration(seconds: 1),
                    child: Text(
                      'Sign up with Email',
                      style: TextStyle(
                        fontSize: w * 0.05,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.018,
                  ),
                  FadeInUp(
                    duration: Duration(seconds: 1),
                    child: Text(
                      'Get chatting with friends and family today by signing up for our chat app!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: w * 0.036, color: Colors.grey.shade500),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.052,
                  ),
                  FadeInLeft(
                    duration: Duration(seconds: 1),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: controller.txtName,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person, color: Colors.white),
                          labelText: 'Name',
                          labelStyle: TextStyle(
                              fontSize: w * 0.038,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                              BorderSide(color: Colors.white, width: 2))),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.018,
                  ),
                  FadeInLeft(
                    duration: Duration(seconds: 1),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: controller.txtEmail,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email, color: Colors.white),
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
                              borderSide:
                              BorderSide(color: Colors.white, width: 2))),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.018,
                  ),
                  Obx(
                        () => FadeInLeft(
                      duration: Duration(seconds: 1),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: controller.txtPassword,
                        cursorColor: Colors.white,
                        obscureText: controller.passwordVisible.value,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock, color: Colors.white),
                            labelText: 'Password',
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
                                    color: Colors.white, width: 2))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.018,
                  ),
                  Obx(
                        () => FadeInLeft(
                      duration: Duration(seconds: 1),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: controller.txtConPassword,
                        cursorColor: Colors.white,
                        obscureText: controller.conPasswordVisible.value,
                        decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            prefixIcon: Icon(Icons.lock, color: Colors.white),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.conPasswordVisible.value =
                                !controller.conPasswordVisible.value;
                              },
                              icon: (controller.conPasswordVisible.value)
                                  ? Icon(Icons.visibility_off,
                                  color: Colors.white)
                                  : Icon(Icons.visibility, color: Colors.white),
                            ),
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
                                    color: Colors.white, width: 2))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.018,
                  ),
                  FadeInLeft(
                    duration: Duration(seconds: 1),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: controller.txtPhone,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone, color: Colors.white),
                          labelText: 'Phone',
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
                              BorderSide(color: Colors.white, width: 2))),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FadeInDown(
                    duration: Duration(seconds: 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have account?",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      print("Button tapped!");
                      print("Password: ${controller.txtPassword.text}");
                      print(
                          "Confirm Password: ${controller.txtConPassword.text}");

                      if (controller.txtEmail.text.contains(
                          RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$')) &&
                          controller.txtEmail.text.isNotEmpty) {
                        if (controller.txtPassword.text.length >= 8) {
                          if (controller.txtPassword.text ==
                              controller.txtConPassword.text) {
                            if (controller.txtPhone.text.length == 10 &&
                                RegExp(r'^[0-9]+$')
                                    .hasMatch(controller.txtPhone.text)) {
                              await AuthService.authService
                                  .createAccountWithEmailAndPassword(
                                  controller.txtEmail.text,
                                  controller.txtPassword.text);

                              UserModal user = UserModal(
                                  email: controller.txtEmail.text,
                                  name: controller.txtName.text,
                                  phone: controller.txtPhone.text,
                                  token: '------',
                                  image:
                                  'https://www.pngkit.com/png/detail/25-258694_cool-avatar-transparent-image-cool-boy-avatar.png');
                              CloudFireStoreService.cloudFireStoreService
                                  .insertUserIntoFireStore(user);

                              Get.offAndToNamed('/home');

                              controller.txtEmail.clear();
                              controller.txtPassword.clear();
                              controller.txtConPassword.clear();
                              controller.txtPhone.clear();
                              controller.txtName.clear();
                            } else {
                              Get.snackbar(
                                'Invalid!',
                                'Mobile number must be 10 digits',
                                backgroundColor: Colors.grey[900],
                                colorText: Colors.white,
                                snackPosition: SnackPosition.TOP,
                                borderRadius: 8,
                                margin: EdgeInsets.all(16),
                                duration: Duration(seconds: 3),
                                icon: Icon(Icons.warning, color: Colors.yellow),
                              );
                            }
                          } else {
                            Get.snackbar(
                              'Invalid!',
                              'Passwords do not match',
                              backgroundColor: Colors.grey[900],
                              colorText: Colors.white,
                              snackPosition: SnackPosition.TOP,
                              borderRadius: 8,
                              margin: EdgeInsets.all(16),
                              duration: Duration(seconds: 3),
                              icon: Icon(Icons.warning, color: Colors.yellow),
                            );
                          }
                        } else {
                          Get.snackbar(
                            'Invalid!',
                            'Password must be at least 8 characters long',
                            backgroundColor: Colors.grey[900],
                            colorText: Colors.white,
                            snackPosition: SnackPosition.TOP,
                            borderRadius: 8,
                            margin: EdgeInsets.all(16),
                            duration: Duration(seconds: 3),
                            icon: Icon(Icons.warning, color: Colors.yellow),
                          );
                        }
                      } else {
                        Get.snackbar(
                          'Invalid!',
                          'Invalid Email Address',
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
                        height: h * 0.064,
                        decoration: BoxDecoration(
                          color: Color(0xff7b829c),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Sign up',
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
        ],
      ),
    );
  }
}