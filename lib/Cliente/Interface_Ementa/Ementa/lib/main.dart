import 'package:pap_projeto/Cliente/Interface_Ementa/Ementa/lib/src/view/screen/home_screen.dart';
import 'package:pap_projeto/Cliente/Interface_Ementa/Ementa/lib/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class pp extends StatelessWidget {
  const pp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: AppTheme.lightAppTheme,
    );
  }
}
