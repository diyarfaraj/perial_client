import 'package:flutter/material.dart';
import 'package:perial/DataLayer/Models/User.dart';
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

  List<User> users = [];

  Future<void> loadData() async {
    var data = await Operations().getUsers(context);
    print(data);

    setState(() {
      users = data;
    });

    print(users);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test user"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return Text(users[index].userName);
          },
        ),
      ),
    );
  }
}
