import 'package:flutter/material.dart';
import 'package:perial/DataLayer/DataService.dart';
import 'package:perial/DataLayer/Models/Member.dart';
import 'package:perial/DataLayer/Models/CurrentUser.dart';
import 'package:perial/DataLayer/Models/UserLike.dart';
import 'package:perial/DataLayer/Operations/LikesOperations.dart';
import 'package:perial/DataLayer/Providers/LikesProvider.dart';
import 'package:perial/DataLayer/Providers/MemberProvider.dart';
import 'package:perial/DataLayer/Providers/UserProvider.dart';
import 'package:perial/Screens/LogInScreen.dart';
import 'package:perial/Screens/LoggedInHomeScreen.dart';
import 'package:provider/provider.dart';

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
  CurrentUser loggedInUser;

  bool _initState = true;
  @override
  void initState() {
    super.initState();
    loggedInUser = currentUser;
  }

  @override
  void didChangeDependencies() {
    if (_initState) {
      Provider.of<MemberProvider>(context).getMembersProvider();
      Provider.of<LikesProvider>(context).getLikesProvider("liked");
    }
    _initState = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var memberData = Provider.of<MemberProvider>(context);
    final members = memberData.members
        .where((member) => member.userName != currentUser.username)
        .toList();
    var likeData = Provider.of<LikesProvider>(context);
    final likedBy = likeData.likedUsers;
    return SingleChildScrollView(
      child: Form(
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
                  onPressed: _submittable()
                      ? () {
                          _formKey.currentState.validate();
                          CurrentUser currUser = CurrentUser(
                              username: _usernameFilter.text,
                              password: _passwordFilter.text);
                          Provider.of<UserProvider>(context, listen: false)
                              .registerUserProvider(currUser);

                          setState(() {
                            _usernameFilter.text = "";
                            _passwordFilter.text = "";
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoggedInHomeScreen()),
                          );
                        }
                      : null,
                  child: const Text('Register'),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text("likedUsers---------------------------------"),
            Center(
              child: SingleChildScrollView(
                child: Container(
                  height: 250,
                  child: likedBy != null
                      ? ListView.builder(
                          itemCount: likedBy.length,
                          itemBuilder: (context, index) {
                            return Center(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        likedBy[index].username,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        )
                      : Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
            Center(
              child: Container(
                height: 400,
                child: members.length > 0
                    ? ListView.builder(
                        itemCount: members.length,
                        itemBuilder: (context, index) {
                          return Center(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      members[index].userName,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      )
                    : Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _submittable() {
    return _agreedToTOS;
  }

  void _submit() async {}

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }
}
