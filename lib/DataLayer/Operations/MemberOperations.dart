import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:perial/DataLayer/Models/Member.dart';
import '../DataService.dart';

class MemberOperations {
  Future<List<Member>> getMembers() async {
    try {
      String os = await DataService().getMembers();
      if ([null, ""].contains(os)) return new List<Member>();
      List<Member> o = Member.parseList(json.decode(os));
      return o;
    } catch (ex) {
      print('MemeberOperations.getMembers() Ex: ' + ex.toString());
    } finally {}
    return new List<Member>();
  }

  Future<Member> getMember(String username) async {
    try {
      String os = await DataService().getMember(username);
      if ([null, ""].contains(os)) return new Member();
      List<Member> o = Member.parseList(json.decode(os));
      return o[0];
    } catch (ex) {
      print('MemeberOperations.getMember() Ex: ' + ex.toString());
    } finally {}
    return new Member();
  }
}
