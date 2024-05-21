import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttergalleryapp/screens/home_screen.dart';
import 'package:fluttergalleryapp/screens/permission_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () async {
      if (await checkPermissionStatus() == false) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => PermissionScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/app_icon.png'),
          CircularProgressIndicator(
            color: Colors.blue,
          )
        ],
      ),
    ));
  }

  Future<bool> checkPermissionStatus() async {
    final permissionPhotos = Permission.storage;
    final permissionCamera = Permission.camera;
    bool check = false;
    if (await permissionPhotos.status.isGranted &&
        await permissionCamera.status.isGranted) {
      check = true;
    }
    return check;
  }
}
