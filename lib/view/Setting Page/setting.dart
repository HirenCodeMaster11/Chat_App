import 'package:chat_app/modal/user.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/cloud_fireStore_service.dart';
import '../../services/google_auth_service.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FutureBuilder(
        future: CloudFireStoreService.cloudFireStoreService
            .readCurrentUserFromFireStore(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          Map? data = snapshot.data!.data();
          UserModal userModal = UserModal.fromMap(data!);

          return Stack(
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
              Column(
                children: [
                  SizedBox(
                    height: h * 0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: w * 0.06,
                          ),
                        ),
                        SizedBox(
                          width: w * 0.29,
                        ),
                        Text(
                          'Settings',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontSize: w * 0.05),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: h * 0.04,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(w * 0.12),
                          topRight: Radius.circular(w * 0.12),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, right: 12, top: 24),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: h * 0.036,
                                  backgroundImage:
                                      NetworkImage(userModal.image),
                                ),
                                SizedBox(
                                  width: w * 0.04,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userModal.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(userModal.phone),
                                  ],
                                ),
                                Spacer(),
                                Icon(
                                  Icons.qr_code_scanner,
                                  color: Color(0xff3e4a7a),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: h * 0.02,
                            ),
                            Divider(
                              color: Color(
                                0xfff5f7f6,
                              ),
                              height: h * 0.001,
                            ),
                            SizedBox(
                              height: h * 0.02,
                            ),
                            GestureDetector(
                              onTap: () async {
                                await AuthService.authService.signOut();
                                await GoogleAuthService.googleAuthService
                                    .signOutFromGoogle();
                                CloudFireStoreService.cloudFireStoreService.toggleOnlineStatus(
                                  false,
                                  Timestamp.now(),
                                  false,
                                );
                              },
                              child: Row(
                                children: [
                                  Container(
                                    height: h * 0.0616,
                                    width: w * 0.1263,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffdeebfe),
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.logout,
                                      color: Color(0xffc7c9c9),
                                    ),
                                  ),
                                  SizedBox(
                                    width: w * 0.06,
                                  ),
                                  Text(
                                    'Log out',
                                    style: TextStyle(
                                      color: Colors.red,
                                        fontSize: w * 0.05,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
