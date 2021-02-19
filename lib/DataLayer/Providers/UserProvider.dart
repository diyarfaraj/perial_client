import 'package:flutter/cupertino.dart';
import 'package:perial/DataLayer/Models/User.dart';
import 'package:perial/DataLayer/Operations.dart';

import '../DataService.dart';

class UserProvider with ChangeNotifier {
  List<User> users = List<User>();
  bool loading = false;

  getUsersProvider() async {
    loading = true;
    users = await Operations().getUsers();
    loading = false;
    notifyListeners();
  }

  registerUserProvider(User user) async {
    loading = true;
    await DataService().register(user.userName, user.password);
    notifyListeners();
    loading = false;
  }
}
