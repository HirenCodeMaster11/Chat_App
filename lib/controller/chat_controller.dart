import 'package:cloud_firestore/cloud_firestore.dart';
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

  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    String amPm = hour >= 12 ? 'PM' : 'AM';
    hour = hour % 12;
    hour = hour == 0 ? 12 : hour; // Convert 0 to 12 for 12-hour format

    String minuteStr = minute < 10 ? '0$minute' : minute.toString(); // Add leading zero if needed
    return '$hour:$minuteStr $amPm';
  }
}
