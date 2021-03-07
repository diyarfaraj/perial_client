import 'package:flutter/cupertino.dart';
import 'package:perial/DataLayer/Models/Member.dart';
import 'package:perial/DataLayer/Models/CurrentUser.dart';
import 'package:perial/DataLayer/Operations/UserOperations.dart';

import '../DataService.dart';

class UserProvider extends ChangeNotifier {
  List<CurrentUser> _users = [];
  CurrentUser currentLoggedinUser;
  bool loading = false;

  List<CurrentUser> get users {
    return [..._users];
  }

  getUsersProvider() async {
    loading = true;
    _users = await UserOperations().getUsers();
    loading = false;
    notifyListeners();
  }

  registerUserProvider(CurrentUser user) async {
    loading = true;
    await DataService().register(user.username, user.password);
    notifyListeners();
    await getUsersProvider();
    loading = false;
  }

  getLoggedInUser() async {}
}
