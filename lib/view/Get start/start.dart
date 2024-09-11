import 'package:flutter/material.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0,right: 16),
        child: Column(
          children: [
            SizedBox(height: h*0.0,),
            Text('Chatbox',textAlign: TextAlign.center,style: TextStyle(fontSize: w*0.05),),
            SizedBox(height: h*0.03,),
            Text(
              'Connect friends easily & quickly',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: w * 0.18,height: h*0.0015),
            ),
            SizedBox(
              height: h*0.02,
            ),
            Text('Our chat app is the perfect way to stay connected with friends and family.',textAlign: TextAlign.left,style: TextStyle(color: Colors.grey,fontSize: w*0.043),),
          ],
        ),
      ),
    );
  }
}
