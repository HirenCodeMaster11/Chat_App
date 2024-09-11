import 'package:cloud_firestore/cloud_firestore.dart';

import '../modal/user.dart';

class CloudFireStoreService {
  CloudFireStoreService._();

  static CloudFireStoreService cloudFireStoreService =
      CloudFireStoreService._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> insertUserIntoFireStore(UserModal user) async {
    await fireStore.collection('users').doc(user.email).set(
      {
        'email': user.email,
        'name': user.name,
        'image' : user.image,
        'phone' : user.phone,
        'token' : user.token,
      },
    );
  }
}
