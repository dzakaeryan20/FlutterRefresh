// import 'dart:html';
// import 'dart:io';
import 'dart:math';

//import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final listData = <User>[];

  @override
  void initState() {
    listData..add(User('User 1', 10, Colors.red))..add(User('User 2', 15, Colors.yellow))..add(User('User 3', 19, Colors.green));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Refresh Pull Down'),
      ),
      body: _buildWidgetListDataAndroid()
    );
  }

  Widget _buildWidgetListDataIOS() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CustomScrollView(
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: refreshData,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  var user = listData[index];
                  return _buildWidgetItemListData(user, context);
                },
                childCount: listData.length
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetListDataAndroid() {
    return RefreshIndicator(
      onRefresh: refreshData,
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemBuilder: (context, index) {
          var user = listData[index];
          return _buildWidgetItemListData(user, context);
        },
        itemCount: listData.length,
      ),
    );
  }

  Widget _buildWidgetItemListData(User user, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: user.color,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.nama),
              Text(
                '${user.nomor}',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future refreshData() async {
    const dataColors = [Colors.red, Colors.yellow, Colors.blue, Colors.green, Colors.orange,Colors.white];
    listData.clear();
    await Future.delayed(Duration(seconds: 1));
    for (var index = 0; index < 10; index++) {
      var nama = 'User ${index + 1}';
      var nomor = Random().nextInt(100);
      var cl = dataColors[Random().nextInt(dataColors.length)];
      print("masuk sini");
      listData.add(User(nama, nomor, cl));
    }
    print(listData);
    setState(() {});
  }
}

class User {
  final String nama;
  final int nomor;
  final color;

  User(this.nama, this.nomor, this.color);
}
//void main() {
//  // Tutorial begininng
//  //runApp(
////    MaterialApp(
////      home: Center(
////        child: Text("Hello Gaes"),
////      ),
////    ),
////  );
//
//// Hot Reload
//  runApp(
//    MyApp()
//  );
//}
//
//class MyApp extends StatelessWidget {
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    // String Texts = refresh();
//
//    return MaterialApp(
//      home: Scaffold(
//        appBar: AppBar(
//          title: Center(
//            child: Text("Demo Refresh"),
//          ),
//        ),
//        backgroundColor: Colors.indigo,
//        body: actionrefrsh(),
//
//      ),
//
//    );
//  }
//
//  Widget actionrefrsh(){
//    print("Return list");
//    return RefreshIndicator(child: Text("Data List"), onRefresh: refresh);
//  }
//
//  Future refresh() async{
//    print("Refresh");
//    await Future.delayed(Duration(seconds: 2));
//    //setState(() {})
//    // return "Demo Refresh ";
//  }
//}














