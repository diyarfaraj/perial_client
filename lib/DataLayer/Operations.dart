import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:perial/DataLayer/Models/User.dart';

import 'DataService.dart';

class Operations {
  Future<List<User>> getUsers(BuildContext context) async {
    try {
      String os = await DataService.getUsers();

      if ([null, ""].contains(os)) return new List<User>();

      List<User> o = User.parseList(json.decode(os));

      return o;
    } catch (ex) {
      print('ApprovalOps.getKioskComponents() Ex: ' + ex.toString());
    } finally {
      //MessageBox.hideLoading(context);
    }

    return new List<User>();
  }
}
