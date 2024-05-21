import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  Future<void> loadImageList() async {
    Map<dynamic, dynamic>  allImageTemp;
    allImageTemp = await FlutterGallaryPlugin.getAllImages;
    print(" call $allImageTemp.length");


    setState(() {
      this.allImage = allImageTemp['URIList'] as List;
      this.allNameList = allImageTemp['DISPLAY_NAME'] as List;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text("Gallery"),
              centerTitle: true,
              bottom: TabBar(
                tabs: [
                  Column(
                    children: [
                      Icon(
                        Icons.photo,
                        color: Colors.blue,
                      ),
                      Text(
                        "Photos",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.video_camera_back_sharp,
                        color: Colors.blue,
                      ),
                      Text(
                        "Videos",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  )
                ],
                indicatorColor: Colors.black,
                indicatorWeight: 1,
              ),
            ),
            drawer: Drawer(
              child: ListView(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: Colors.white10),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/app_icon.png",
                          width: 80,
                          height: 80,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Gallery",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    title: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Home",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Fav",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "About Us",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(children: [
              Container(
                child: GridView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: 100,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:[ Icon(Icons.photo),]);
                    }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                  ),
              ),
              Container(
                child: GridView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:[ Icon(Icons.photo),]);
                  }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                ),
              ),
            ])),
      ),
    );
  }
}
