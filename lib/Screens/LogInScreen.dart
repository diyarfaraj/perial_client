import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:perial/DataLayer/DataService.dart';
import 'package:perial/DataLayer/Models/User.dart';
import 'package:perial/Screens/RegisterScreen.dart';
import 'LoggedInHomeScreen.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

// Used for controlling whether the user is loggin or creating an account
enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailFilter = TextEditingController();
  final TextEditingController _passwordFilter = TextEditingController();
  String _email = "";
  String _password = "";
  FormType _form = FormType
      .login; // our default setting is to login, and we should switch to creating an account when the user chooses to
  bool loggedIn = false;
  User loggedInUser;
  _LoginPageState() {
    _emailFilter.addListener(_emailListen);
    _passwordFilter.addListener(_passwordListen);
  }

  void _emailListen() {
    if (_emailFilter.text.isEmpty) {
      _email = "";
    } else {
      _email = _emailFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }

  // Swap in between our two forms, registering and logging in
  void _formChange() async {
    setState(() {
      if (_form == FormType.register) {
        _form = FormType.login;
      } else {
        _form = FormType.register;
      }
    });
  }

  Future<bool> login(User user) async {
    var response = await DataService().login(user.userName, user.password);
    print(response);
    if (response.statusCode == 200) {
      setState(() {
        loggedIn = true;
        loggedInUser = User.fromJson(jsonDecode(response.body));
      });
      print(loggedInUser.userName);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> register(User user) async {
    var response = await DataService().register(user.userName, user.password);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildTextFields(),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return AppBar(
      title: Text("Simple Login Example"),
      centerTitle: true,
    );
  }

  Widget _buildTextFields() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: TextField(
              controller: _emailFilter,
              decoration: InputDecoration(labelText: 'Email'),
            ),
          ),
          Container(
            child: TextField(
              controller: _passwordFilter,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtons() {
    if (_form == FormType.login) {
      return Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('Login'),
              onPressed: _loginPressed,
            ),
            FlatButton(
              child: Text('Dont have an account? Tap here to register.'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
            ),
            FlatButton(
              child: Text('Forgot Password?'),
              onPressed: _passwordReset,
            )
          ],
        ),
      );
    } else {
      return Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('Create an Account'),
              onPressed: () {},
            ),
            FlatButton(
              child: Text('Have an account? Click here to login.'),
              onPressed: _formChange,
            )
          ],
        ),
      );
    }
  }

  // These functions can self contain any user auth logic required, they all have access to _email and _password

  void _loginPressed() async {
    User currUser =
        User(userName: _emailFilter.text, password: _passwordFilter.text);
    var response = await login(currUser);

    if (response == true) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoggedInHomeScreen()),
      );
    }
  }

  void _passwordReset() {
    print("The user wants a password reset request sent to $_email");
  }
}

class SecondRoute extends StatelessWidget {
  User user;
  SecondRoute(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Column(
          children: [
            Icon(
              Icons.check_circle_rounded,
              size: 80,
              color: Colors.green,
            ),
            Text("welcome user: " + user.userName)
          ],
        ),
      ),
    );
  }
}
