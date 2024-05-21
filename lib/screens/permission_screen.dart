import 'package:flutter/material.dart';
import 'package:fluttergalleryapp/screens/home_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  @override
  Widget build(BuildContext context) {
    print("Enter Permission screen");
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back_ios_outlined),
          title: Text("Permission"),
          centerTitle: true,
        ),
        body: Container(
          // width: MediaQuery.of(context).devicePixelRatio,
          // height: MediaQuery.of(context).devicePixelRatio,
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Read Photos Permission",
                style: TextStyle(fontSize: 25),
              ),
              Container(
                height: 50,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(15),
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          side: BorderSide(color: Colors.cyan))),
                  onPressed: () async {
                    if (!await checkPermissionStatus()) {
                      requestPermission();
                    }
                  },
                  child: Container(
                      decoration: BoxDecoration(),
                      child: Text(
                        "Give Permission",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )))
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

  Future<void> requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.camera,
    ].request();

    if (await statuses[Permission.storage]!.isGranted &&
        statuses[Permission.camera]!.isGranted) {
      goNext();
    } else {
      openAppSettings();
    }
  }

  void goNext() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
