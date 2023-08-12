import 'package:flutter/material.dart';

final class StyleRepo with ChangeNotifier {
  bool useGPNTheme;

  StyleRepo._() : useGPNTheme = true;

  static StyleRepo? _instance;

  factory StyleRepo() => _instance ??= StyleRepo._();

  void changeTheme(bool value) {
    useGPNTheme = value;
    notifyListeners();
  }
}
