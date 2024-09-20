import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  RxString receiverEmail = ''.obs;
  RxString receiverName = ''.obs;
  RxString receiverImg = ''.obs;

  TextEditingController txtMessage = TextEditingController();
  TextEditingController txtUpdateMessage = TextEditingController();

  RxBool isTyping = false.obs;
  RxBool isOnline = false.obs;
  Rx<DateTime> lastSeen = DateTime.now().obs;

  void getReceiver(String email, String name, String img) {
    receiverEmail.value = email;
    receiverName.value = name;
    receiverImg.value = img;
  }
}
