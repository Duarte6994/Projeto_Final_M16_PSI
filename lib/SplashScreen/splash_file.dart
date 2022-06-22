import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pap_projeto/Cliente/Interface_Ementa/Ementa/lib/main.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super (key:key);
  
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const pp()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/Icons/splash_icon.png',
            height: 500,
            ),
            const SizedBox(height: 30,),
            const CircularProgressIndicator(
              color: Colors.black,
            )
          ],
        )
      ),
    );
  }
}