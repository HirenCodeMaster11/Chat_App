import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../services/auth_services.dart';

class AuthController extends GetxController
{
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConPassword = TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  RxBool passwordVisible = false.obs;
  RxBool conPasswordVisible = false.obs;

  Future<void> createAccountValidation(
      String email, String password, String confirmPassword) async {
    if (email.contains(RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$')) &&
        email.isNotEmpty) {
      if (password.length >= 6) {
        if (password == confirmPassword) {
          await AuthService.authService.createAccountWithEmailAndPassword(
            email,password,
          );
          Get.toNamed('/signIn');
        } else {
          Get.snackbar('Invalid!', 'Passwords not match');
        }
      } else {
        Get.snackbar('Invalid!', 'Password must be 6 character long');
      }
    } else {
      Get.snackbar('Invalid!', 'Invalid Email Address');
    }
  }
}