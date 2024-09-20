import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
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
          Padding(
            padding: const EdgeInsets.only(left: 16.0,right: 16),
            child: Column(
              children: [
                SizedBox(height: h*0.048,),
                FadeInLeft(
                  child: Text(
                    'Connect friends easily & quickly',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white, fontSize: w * 0.18,height: h*0.0015),
                  ),
                ),
                SizedBox(
                  height: h*0.036,
                ),
                FadeInUp(child: Text('Our chat app is the perfect way to stay connected with friends and family.',textAlign: TextAlign.center,style: TextStyle(color: Colors.grey,fontSize: w*0.043),)),
                SizedBox(
                  height: h*0.026,
                ),
                SizedBox(
                  height: h * 0.026,
                ),
                FadeInDown(
                  duration: Duration(seconds: 1),
                  child: TextButton(
                      onPressed: () {
                        Get.toNamed('/signIn');
                      },
                      child: Text("Already have account? Sign In",style: TextStyle(color: Colors.white),)),
                ),
                SizedBox(
                  height: h*0.02,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'OR',
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: h * 0.012,
                ),

                SizedBox(
                  height: h * 0.02,
                ),
                FadeInDown(
                  duration: Duration(seconds: 1),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed('/signUp');
                    },
                    child: Container(
                      height: h * 0.064,
                      decoration: BoxDecoration(
                        color: Color(0xff7b829c),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Sign up with mail',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: w * 0.047,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
