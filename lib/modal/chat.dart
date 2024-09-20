import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String sender;
  String receiver;
  String message;
  Timestamp time;
  bool isRead;
  bool isTyping;

  ChatModel({
    required this.sender,
    required this.receiver,
    required this.message,
    required this.time,
    this.isRead = false,     // Default value is false, as messages are initially unread
    this.isTyping = false,   // Default value is false, indicating user is not typing
  });

  factory ChatModel.fromMap(Map<String, dynamic> m1) {
    return ChatModel(
      sender: m1['sender'] ?? '',
      receiver: m1['receiver']?? '',
      message: m1['message']?? '',
      time: m1['time']?? '',
      isRead: m1['isRead'] ?? false,   // Handle possible null
      isTyping: m1['isTyping'] ?? false,  // Handle possible null
    );
  }

  Map<String, dynamic> toMap(ChatModel chat) {
    return {
      'sender': chat.sender,
      'receiver': chat.receiver,
      'message': chat.message,
      'time': chat.time,
      'isRead': chat.isRead,
      'isTyping': chat.isTyping,
    };
  }
}
