import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: CupertinoColors.white,
        body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/image/logo.png",height: 150,color: Colors.black,),
            Center(child: Text("Study Tracker", style: TextStyle(fontFamily: "Oswald",fontSize: 60),)),
            Text("Track. Study. Succeed.", style: TextStyle(fontSize: 20, fontFamily: "Oswald"),),
            SizedBox(height: 300,),
            ElevatedButton(onPressed: (){Navigator.pushNamed(context, '/LoginScreen');}, child: Text("Get Started",style: TextStyle(fontSize: 30 ,color: Colors.black ,), ))
            
        ],) ,
      ),
      
    );
  }
}