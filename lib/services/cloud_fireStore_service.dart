import 'package:chat_app/modal/chat.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../modal/user.dart';

class CloudFireStoreService {
  CloudFireStoreService._();

  static CloudFireStoreService cloudFireStoreService =
  CloudFireStoreService._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  // Insert user into Firestore
  Future<void> insertUserIntoFireStore(UserModal user) async {
    await fireStore.collection('users').doc(user.email).set(
      {
        'email': user.email,
        'name': user.name,
        'image': user.image,
        'phone': user.phone,
        'token': user.token,
        'isTyping': false,
        'isOnline': false,
        'read': user.isRead,
        'lastSeen': Timestamp.now(),
      },
    );
  }

  // Read current user from Firestore
  Future<DocumentSnapshot<Map<String, dynamic>>> readCurrentUserFromFireStore()
  async {
    User? user = AuthService.authService.getCurrentUser();
    return await fireStore.collection('users').doc(user!.email).get();
  }

  // Read all users except the current one
  Future<QuerySnapshot<Map<String, dynamic>>> readAllUsersFromFireStore()
  async {
    User? user = AuthService.authService.getCurrentUser();
    return await fireStore.collection('users')
        .where('email', isNotEqualTo: user!.email).get();
  }

  // Add chat in Firestore
  Future<void> addChatInFireStore(ChatModel chat) async {
    String sender = chat.sender;
    String receiver = chat.receiver;
    List<String> doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("_");

    await fireStore.collection("chatroom").doc(docId).collection('chat')
        .add(chat.toMap(chat));
  }

  // Read chat from Firestore
  Stream<QuerySnapshot<Map<String, dynamic>>> readChatFromFireStore(
      String receiver) {
    String? sender = AuthService.authService.getCurrentUser()!.email;
    List<String> doc = [sender!, receiver];
    doc.sort();
    String docId = doc.join("_");

    return fireStore.collection("chatroom").doc(docId).collection('chat')
        .orderBy('time', descending: false).snapshots();
  }

  // Update chat message
  Future<void> updateChat(String receiver, String dcId, String message) async {
    String? sender = AuthService.authService.getCurrentUser()!.email;
    List<String> doc = [sender!, receiver];
    doc.sort();
    String docId = doc.join("_");

    return await fireStore.collection("chatroom").doc(docId).collection('chat')
        .doc(dcId).update({'message': message});
  }

  // Remove chat message
  Future<void> removeChat(String receiver, String dcId) async {
    String? sender = AuthService.authService.getCurrentUser()!.email;
    List<String> doc = [sender!, receiver];
    doc.sort();
    String docId = doc.join("_");

    await fireStore.collection('chatroom').doc(docId).collection('chat')
        .doc(dcId).delete();
  }

  Future<void> updateMessageReadStatus(String receiver, String dcId) async {
    String? sender = AuthService.authService.getCurrentUser()!.email;
    List<String> doc = [sender!, receiver];
    doc.sort();
    String docId = doc.join("_");

    await fireStore.collection('chatroom').doc(docId).collection('chat')
        .doc(dcId).update({'isRead': true});
  }

  Future<void> toggleOnlineStatus(
      bool status, Timestamp lastSeen, bool isTyping) async {
    String email = AuthService.authService.getCurrentUser()!.email!;
    await fireStore.collection("users").doc(email).update({
      'isOnline': status,
      'lastSeen': lastSeen,
      'isTyping': isTyping,
    });
  }

  // void changeTypingStatusReceiver(bool status){
  //   String senderEmail = AuthService.authService.getCurrentUser()!.email!;
  //   fireStore.collection("users").doc(senderEmail).update({"isTyping": status});
  // }

  Stream<DocumentSnapshot<Map<String, dynamic>>> checkUserIsOnlineOrNot(
      String email) {
    return fireStore.collection("users").doc(email).snapshots();
  }

}
