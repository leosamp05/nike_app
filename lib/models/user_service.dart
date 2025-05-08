import 'package:flutter/foundation.dart';

class UserService extends ChangeNotifier {
  UserService._();
  static final UserService instance = UserService._();

  String _userName = "User";
  String get userName => _userName;

  void setUserName(String newName) {
    if (newName.trim().isEmpty) return;
    _userName = newName;
    notifyListeners();
  }
}
