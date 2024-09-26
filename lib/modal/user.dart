import 'package:cloud_firestore/cloud_firestore.dart';

class UserModal {
  String email, name, image, phone, token;
  bool isRead;
  Timestamp lastSeen;
  bool isTyping,isOnline;

  UserModal({
    required this.email,
    required this.name,
    required this.phone,
    required this.token,
    required this.image,
    this.isRead =
        false, // Default value is false, as messages are initially unread
    required this.isTyping,
    required this.isOnline,
    required this.lastSeen,
  });

  factory UserModal.fromMap(Map m1) {
    return UserModal(
      email: m1['email'],
      name: m1['name'],
      phone: m1['phone'],
      token: m1['token'],
      image: m1['image'],
      isRead: m1['isRead'] ?? false,
      isTyping: m1['isTyping'] ?? false,
      isOnline: m1['isOnline'] ?? false,
      lastSeen: m1['lastSeen'],
    );
  }

  Map<String, dynamic> toMap(UserModal user) {
    return {
      'name': user.name,
      'email': user.email,
      'image': user.image,
      'phone': user.phone,
      'token': user.token,
      'isTyping': user.isTyping,
      'read': user.isRead,
      'isOnline' : user.isOnline,
      'lastSeen' : user.lastSeen,
    };
  }
}
