// import 'dart:html';
// import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show TargetPlatform;
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
    listData..add(User(Colors.red))..add(User(Colors.yellow))..add(User(Colors.green));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var platform = Theme.of(context).platform;
    return Scaffold(
      appBar: AppBar(
        title: Text('Refresh Pull Down'),
      ),
      body: platform == TargetPlatform.android ?  _buildWidgetListDataAndroid() : _buildWidgetListDataIOS()
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
              Center(
                child: Text('Text Color'),

              )
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
      var cl = dataColors[Random().nextInt(dataColors.length)];
      print("masuk sini");
      listData.add(User(cl));
    }
    print(listData);
    setState(() {});
  }
}

class User {
  final color;
  User(this.color);
}