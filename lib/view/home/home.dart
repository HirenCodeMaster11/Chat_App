import 'package:chat_app/modal/user.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/services/cloud_fireStore_service.dart';
import 'package:chat_app/view/Chat%20Page/chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FutureBuilder(
        future: CloudFireStoreService.cloudFireStoreService
            .readAllUsersFromFireStore(),
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
          List<UserModal> userList = [];
          for (var user in data) {
            userList.add(UserModal.fromMap(user.data()));
          }
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 30,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(color: Colors.white, fontSize: 23),
                        ),
                        CircleAvatar(
                          radius: h * 0.028,
                          backgroundImage: AuthService.authService.getCurrentUser()?.photoURL != null
                              ? NetworkImage(AuthService.authService.getCurrentUser()!.photoURL!) : NetworkImage('https://www.pngkit.com/png/detail/25-258694_cool-avatar-transparent-image-cool-boy-avatar.png'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  SizedBox(
                    height: h * 0.15,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: userList.length, // Replace with actual count
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: w * 0.086,
                                backgroundImage:
                                    NetworkImage(userList[index].image),
                              ),
                              SizedBox(height: h*0.01),
                              SizedBox(
                                width: w*0.18,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  userList[index].name,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: w*0.034, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
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
                      child: ListView.builder(
                        itemCount: userList.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ListTile(
                            onTap: () {
                              chatController.getReceiver(userList[index].email, userList[index].name,userList[index].image);
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatPage(img: userList[index].image),));
                            },
                            leading: CircleAvatar(
                              radius: w * 0.066,
                              backgroundImage:
                                  NetworkImage(userList[index].image),
                            ),
                            title: Text(userList[index].name),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('2 min ago',style: TextStyle(color: Color(0xffbcbebd),fontWeight: FontWeight.w400),),
                                SizedBox(height: 4),
                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.red,
                                  child: Text(
                                    '3',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
      bottomNavigationBar: HomeBottomNavigation(),
    );
  }
}

class HomeBottomNavigation extends StatefulWidget {
  @override
  _HomeBottomNavigationState createState() => _HomeBottomNavigationState();
}

class _HomeBottomNavigationState extends State<HomeBottomNavigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (_selectedIndex == 3) {
        Get.toNamed('/set')?.then((_) {
          setState(() {
            _selectedIndex = 0;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      unselectedItemColor: Colors.grey.shade400,
      selectedItemColor: const Color(0xff3e4a7a),
      selectedIconTheme: IconThemeData(
        color: Color(0xff3e4a7a),
      ),
      unselectedIconTheme: IconThemeData(
        color: Colors.grey.shade400,
      ),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.message,),
          label: 'Message',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.call),
          label: 'Calls',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.contacts),
          label: 'Contacts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
