import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:perial/DataLayer/Models/Member.dart';

import '../DataService.dart';
import '../Models/User.dart';

class UserOperations {
  Future<List<User>> getUsers() async {
    try {
      String os = await DataService().getUsers();

      if ([null, ""].contains(os)) return new List<User>();

      List<User> o = User.parseList(json.decode(os));

      return o;
    } catch (ex) {
      print('ApprovalOps.getKioskComponents() Ex: ' + ex.toString());
    } finally {}

    return new List<User>();
  }
}
