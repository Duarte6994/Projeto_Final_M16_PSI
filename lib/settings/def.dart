import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pap_projeto/settings/profile_menu.dart';
import 'package:pap_projeto/settings/profile_pic.dart';

import '../Administrador/Login/Login.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SizedBox(height: 40),
          ProfilePic(),
          SizedBox(height: 30),
          Text("My Coffee",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            fontFamily: 'Varela'
          ),),
          SizedBox(height: 10),
          Text("Definições",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
                fontFamily: 'Varela',
                color: Colors.orange,
            ),),
          SizedBox(height: 50),
          Padding(padding: EdgeInsets.only(left: 10.0, right: 10.0),
          ),
          ProfileMenu(
            text: "Língua",
            icon: "assets/images/SVG/settings.svg",
            press: () { },
          ),
          ProfileMenu(
            text: "Sobre Nós",
            icon: "assets/images/SVG/acerca.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log In",
            icon: "assets/images/SVG/login.svg",
            press: () {
              Navigator.of(context).push(
                  MaterialPageRoute(
                  builder: (context) => loginpage(),
                )
              );
            },
          ),
        ],
      ),
    );
  }
}
