import 'package:chat_app/controller/chat_controller.dart';
import 'package:chat_app/modal/chat.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/services/cloud_fireStore_service.dart';
import 'package:chat_app/services/local%20notification%20service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var chatController = Get.put(ChatController());

class ChatPage extends StatelessWidget {
  final String? img;

  ChatPage({super.key, this.img});

  // FocusNode focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: h * 0.02,
          ),
          Container(
            height: h * 0.1,
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                CircleAvatar(
                  radius: h * 0.032,
                  backgroundImage: NetworkImage(img!),
                ),
                SizedBox(width: w * 0.033),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      chatController.receiverName.value,
                      style: TextStyle(fontSize: w * 0.044),
                      overflow: TextOverflow.ellipsis,
                    ),
                    StreamBuilder(
                      stream: CloudFireStoreService.cloudFireStoreService
                          .checkUserIsOnlineOrNot(
                              chatController.receiverEmail.value),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text('');
                        }

                        Map? user = snapshot.data!.data();
                        String nightDay = '';
                        if (user!['lastSeen'].toDate().hour > 11) {
                          nightDay = 'PM';
                        } else {
                          nightDay = 'AM';
                        }
                        return Text(
                          user['isOnline']
                              ? (user['isTyping'])
                                  ? 'Typing...'
                                  : 'Online'
                              : 'Last seen at ${user['lastSeen'].toDate().hour % 12}:${user['lastSeen'].toDate().minute} $nightDay',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.call_outlined, size: w * 0.076),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.videocam_outlined, size: w * 0.076),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: CloudFireStoreService.cloudFireStoreService
                  .readChatFromFireStore(chatController.receiverEmail.value),
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

                List data = snapshot.data!.docs;
                List<ChatModel> chatList = [];
                List<String> docIdList = [];
                for (var snap in data) {
                  docIdList.add(snap.id);
                  chatList.add(
                    ChatModel.fromMap(snap.data() as Map<String, dynamic>),
                  );
                }

                // Scroll to bottom when new data is loaded
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollToBottom();
                });

                return SingleChildScrollView(
                  controller: _scrollController, // Attach ScrollController
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ...List.generate(chatList.length, (index) {
                        if (chatList[index].isRead == false &&
                            chatList[index].receiver ==
                                AuthService.authService
                                    .getCurrentUser()!
                                    .email) {
                          CloudFireStoreService.cloudFireStoreService
                              .updateMessageReadStatus(
                                  chatController.receiverEmail.value,
                                  docIdList[index]);
                        }
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8, right: 14, left: 14),
                          child: Container(
                            alignment: (chatList[index].sender ==
                                    AuthService.authService
                                        .getCurrentUser()!
                                        .email!)
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: (chatList[index].sender ==
                                        AuthService.authService
                                            .getCurrentUser()!
                                            .email!)
                                    ? Color(0xff3D4A74)
                                    : Color(0xffF2F7FB),
                                borderRadius: (chatList[index].sender ==
                                        AuthService.authService
                                            .getCurrentUser()!
                                            .email!)
                                    ? BorderRadius.only(
                                        topLeft: Radius.circular(13),
                                        bottomLeft: Radius.circular(13),
                                        bottomRight: Radius.circular(13),
                                      )
                                    : BorderRadius.only(
                                        topRight: Radius.circular(13),
                                        bottomLeft: Radius.circular(13),
                                        bottomRight: Radius.circular(13),
                                      ),
                              ),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onLongPress: () {
                                      if (chatList[index].sender ==
                                          AuthService.authService
                                              .getCurrentUser()!
                                              .email!) {
                                        chatController.txtUpdateMessage =
                                            TextEditingController(
                                                text: chatList[index].message);
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('Update'),
                                              content: TextField(
                                                controller: chatController
                                                    .txtUpdateMessage,
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    String dcId =
                                                        docIdList[index];
                                                    CloudFireStoreService
                                                        .cloudFireStoreService
                                                        .updateChat(
                                                            chatController
                                                                .receiverEmail
                                                                .value,
                                                            dcId,
                                                            chatController
                                                                .txtUpdateMessage
                                                                .text);
                                                    Get.back();
                                                  },
                                                  child: Text('Update'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                    onDoubleTap: () {
                                      if (chatList[index].sender ==
                                          AuthService.authService
                                              .getCurrentUser()!
                                              .email!) {
                                        CloudFireStoreService
                                            .cloudFireStoreService
                                            .removeChat(
                                                chatController
                                                    .receiverEmail.value,
                                                docIdList[index]);
                                      }
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          chatList[index].message,
                                          style: TextStyle(
                                            color: chatList[index].sender ==
                                                    AuthService.authService
                                                        .getCurrentUser()!
                                                        .email!
                                                ? Colors
                                                    .white // Text color for sent messages
                                                : Colors.black,
                                            // Text color for received messages
                                            fontSize: w * 0.042,
                                          ),
                                        ),
                                        SizedBox(
                                          height: h * 0.002,
                                          width: w * 0.02,
                                        ),
                                        Text(
                                          chatController.formatTimestamp(
                                              chatList[index].time),
                                          style: TextStyle(
                                            color: chatList[index].sender ==
                                                    AuthService.authService
                                                        .getCurrentUser()!
                                                        .email!
                                                ? Colors
                                                    .white // Time color for sent messages
                                                : Colors.grey.shade600,
                                            // Time color for received messages
                                            fontSize: w * 0.0344, // Font size
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        if (chatList[index].isRead &&
                                            chatList[index].sender ==
                                                AuthService.authService
                                                    .getCurrentUser()!
                                                    .email!)
                                          Icon(
                                            Icons.done_all_rounded,
                                            // Read status icon
                                            color: Colors.blue.shade400,
                                            size: 18,
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.attach_file_outlined,
                  color: Color(0xff808684),
                ),
              ),
              Expanded(
                child: TextField(
                  // focusNode: focusNode,
                  onChanged: (value) {
                    chatController.txtMessage.text = value;
                    CloudFireStoreService.cloudFireStoreService
                        .toggleOnlineStatus(
                      true,
                      Timestamp.now(),
                      true,
                    );
                  },
                  onTapOutside: (event) {
                    CloudFireStoreService.cloudFireStoreService
                        .toggleOnlineStatus(
                      true,
                      Timestamp.now(),
                      false,
                    );
                  },
                  cursorColor: Colors.black,
                  controller: chatController.txtMessage,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 14),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    hintText: 'Write your message',
                    hintStyle: TextStyle(
                        color: Color(0xffb5b9ba), fontWeight: FontWeight.w400),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Colors.grey.shade100,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Colors.grey.shade100,
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        String message = chatController.txtMessage.text.trim();

                        if (message.isNotEmpty) {
                          ChatModel chat = ChatModel(
                            sender: AuthService.authService
                                .getCurrentUser()!
                                .email!,
                            receiver: chatController.receiverEmail.value,
                            message: chatController.txtMessage.text,
                            time: Timestamp.now(),
                          );
                          await CloudFireStoreService.cloudFireStoreService
                              .addChatInFireStore(chat);

                          await LocalNotificationService.notificationService
                              .showNotification(
                                  AuthService.authService
                                      .getCurrentUser()!
                                      .email!,
                                  chatController.txtMessage.text);

                          chatController.txtMessage.clear();
                          _scrollToBottom();
                          CloudFireStoreService.cloudFireStoreService
                              .toggleOnlineStatus(
                            true,
                            Timestamp.now(),
                            false,
                          );
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        color: Color(0xff3c4a7a),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.camera,
                  color: Color(0xff808684),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.mic,
                  color: Color(0xff808684),
                ),
              ),
            ],
          ),
          SizedBox(
            height: h * 0.02,
          ),
        ],
      ),
    );
  }
}
