import 'package:flutter/material.dart';
import 'package:perial/DataLayer/DataService.dart';
import 'package:perial/DataLayer/Models/User.dart';
import 'package:perial/Screens/LogInScreen.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;
  final TextEditingController _usernameFilter = TextEditingController();
  final TextEditingController _passwordFilter = TextEditingController();
  User loggedInUser;

  Future<bool> register(User user) async {
    var response = await DataService().register(user.userName, user.password);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _usernameFilter,
            decoration: const InputDecoration(
              labelText: 'Username',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Username is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _passwordFilter,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Password is required';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Checkbox(
                  value: _agreedToTOS,
                  onChanged: _setAgreedToTOS,
                ),
                GestureDetector(
                  onTap: () => _setAgreedToTOS(!_agreedToTOS),
                  child: const Text(
                    'I agree to the Terms of Services and Privacy Policy',
                    softWrap: true,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              const Spacer(),
              OutlineButton(
                highlightedBorderColor: Colors.black,
                onPressed: _submittable() ? _submit : null,
                child: const Text('Register'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _submittable() {
    return _agreedToTOS;
  }

  void _submit() async {
    _formKey.currentState.validate();

    User currUser =
        User(userName: _usernameFilter.text, password: _passwordFilter.text);
    var response = await register(currUser);

    if (response == true) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SecondRoute(loggedInUser)),
      );
    }
  }

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }
}
