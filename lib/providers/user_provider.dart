import 'package:flutter/material.dart';
import 'package:laundropool/resources/auth_methods.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser  =>  _user ?? const User(
    username: "",
      uid: "",
      email: "",
      photoUrl: "",
      hostel: "",
      roomNumber: "",
      phoneNumber: "",
      pools: [],
      userPools: []
  );

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}