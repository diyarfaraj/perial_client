import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:perial/DataLayer/Models/Member.dart';

import '../DataService.dart';
import '../Models/CurrentUser.dart';

class UserOperations {
  Future<List<CurrentUser>> getUsers() async {
    try {
      String os = await DataService().getUsers();

      if ([null, ""].contains(os)) return new List<CurrentUser>();

      List<CurrentUser> o = CurrentUser.parseList(json.decode(os));

      return o;
    } catch (ex) {
      print('ApprovalOps.getKioskComponents() Ex: ' + ex.toString());
    } finally {}

    return new List<CurrentUser>();
  }
}
