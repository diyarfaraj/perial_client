import 'package:flutter/material.dart';
import 'package:perial/DataLayer/Operations.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    var data = await Operations().getUsers(context);
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test user"),
      ),
      body: Center(
        child: Column(children: [Text("test")]),
      ),
    );
  }
}
