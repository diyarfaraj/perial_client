import 'package:flutter/cupertino.dart';
import 'package:perial/DataLayer/DataService.dart';
import 'package:perial/DataLayer/Models/UserLike.dart';
import 'package:perial/DataLayer/Operations/LikesOperations.dart';

class LikesProvider extends ChangeNotifier {
  List<UserLike> _likedBy = [];
  List<UserLike> _likedUsers = [];

  UserLike _userLike;
  bool loading = false;

  List<UserLike> get likedBy {
    return [..._likedBy];
  }

  List<UserLike> get likedUsers {
    return [..._likedUsers];
  }

  addLike(String username) async {
    await LikesOperations().addLike(username);
    notifyListeners();
  }

  Future<List<UserLike>> getLikesProvider(String command) async {
    loading = true;
    if (command == "liked") {
      _likedUsers = await LikesOperations().getLikes("liked");
      notifyListeners();
      return _likedUsers;
    }
    _likedBy = await LikesOperations().getLikes("likedBy");
    notifyListeners();
    loading = false;
    return _likedBy;
  }
}
