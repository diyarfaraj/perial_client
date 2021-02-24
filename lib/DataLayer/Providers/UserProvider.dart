import 'package:flutter/cupertino.dart';
import 'package:perial/DataLayer/Models/User.dart';
import 'package:perial/DataLayer/Operations.dart';

import '../DataService.dart';

class UserProvider extends ChangeNotifier {
  List<User> _users = [];
  User currentLoggedinUser;
  bool loading = false;

  List<User> get users {
    return [..._users];
  }

  getUsersProvider() async {
    loading = true;
    _users = await Operations().getUsers();
    loading = false;
    notifyListeners();
  }

  registerUserProvider(User user) async {
    loading = true;
    await DataService().register(user.userName, user.password);
    notifyListeners();
    await getUsersProvider();
    loading = false;
  }

  getLoggedInUser() async {}
}
