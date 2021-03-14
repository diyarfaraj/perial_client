import 'package:flutter/cupertino.dart';
import 'package:perial/DataLayer/DataService.dart';
import 'package:perial/DataLayer/Models/UserDislike.dart';
import 'package:perial/DataLayer/Models/UserLike.dart';
import 'package:perial/DataLayer/Operations/DislikesOperations.dart';
import 'package:perial/DataLayer/Operations/LikesOperations.dart';

class DislikesProvider extends ChangeNotifier {
  List<UserDislike> _dislikedBy = [];
  List<UserDislike> _dislikedUsers = [];

  UserDislike _userLike;
  bool loading = false;

  List<UserDislike> get likedBy {
    return [..._dislikedBy];
  }

  List<UserDislike> get likedUsers {
    return [..._dislikedUsers];
  }

  addDislike(String username) async {
    await DislikesOperations().addDislike(username);
    notifyListeners();
  }

  Future<List<UserDislike>> getDislikesProvider(String command) async {
    loading = true;
    if (command == "liked") {
      _dislikedUsers = await DislikesOperations().getDislikes("liked");
      notifyListeners();
      return _dislikedUsers;
    }
    _dislikedBy = await DislikesOperations().getDislikes("likedBy");
    notifyListeners();
    loading = false;
    return _dislikedBy;
  }
}
