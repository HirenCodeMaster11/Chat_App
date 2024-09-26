import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modal/user.dart';
import '../services/auth_services.dart';
import '../services/cloud_fireStore_service.dart';

class AuthController extends GetxController
{
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConPassword = TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  RxBool passwordVisible = true.obs;
  RxBool conPasswordVisible = true.obs;
  final isLoading = false.obs;

  Future<void> signUp() async {
    if (isLoading.value) return;

    isLoading.value = true;

    try {
      String email = txtEmail.text.trim();
      String password = txtPassword.text.trim();
      String name = txtName.text.trim();
      String phone = txtPhone.text.trim();

      await AuthService.authService.createAccountWithEmailAndPassword(email, password);

      UserModal user = UserModal(
        lastSeen: Timestamp.now(),
        email: email,
        name: name,
        phone: phone,
        isOnline: true,
        isTyping: true,
        token: '------',
        image:'https://www.pngkit.com/png/detail/25-258694_cool-avatar-transparent-image-cool-boy-avatar.png'
      );

      await CloudFireStoreService.cloudFireStoreService.insertUserIntoFireStore(user);

      Get.offAndToNamed('/home');

      txtEmail.clear();
      txtPassword.clear();
      txtConPassword.clear();
      txtPhone.clear();
      txtName.clear();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to sign up. Please try again.',
        backgroundColor: Colors.grey[900],
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        borderRadius: 8,
        margin: EdgeInsets.all(16),
        duration: Duration(seconds: 3),
        icon: Icon(Icons.error, color: Colors.red),
      );
    } finally {
      isLoading.value = false;
    }
  }
}