import 'package:flutter/material.dart';
import 'package:perial/DataLayer/Models/Member.dart';
import 'package:perial/DataLayer/Models/CurrentUser.dart';
import 'package:perial/DataLayer/Operations/UserOperations.dart';
import 'package:perial/Screens/LogInScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginPage(),
    );
  }
}
