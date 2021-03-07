import 'package:flutter/cupertino.dart';
import 'package:perial/DataLayer/Models/Member.dart';
import 'package:perial/DataLayer/Operations/MemberOperations.dart';

class MemberProvider extends ChangeNotifier {
  List<Member> _members = [];
  Member _member;
  bool loading = false;

  List<Member> get members {
    return [..._members];
  }

  getMembersProvider() async {
    loading = true;
    _members = await MemberOperations().getMembers();
    loading = false;
    notifyListeners();
  }

  getMemberProvider(String username) async {
    loading = true;
    _member = await MemberOperations().getMember(username);
    notifyListeners();
    loading = false;
  }
}
