import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class pic_login extends StatelessWidget {
  const pic_login({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      width: 125,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/Icons/splash_icon.png"),
          ),
        ],
      ),
    );
  }
}