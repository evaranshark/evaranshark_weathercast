import 'package:evaranshark_weathercast/services/themes.dart';
import 'package:flutter/material.dart';

final class StyleRepo with ChangeNotifier {
  bool useGPNTheme;
  final EvaransharkTheme _evaransharkTheme = EvaransharkTheme.initTheme();
  final GPNTheme _gpnTheme = GPNTheme.initTheme();

  ThemeData get theme =>
      useGPNTheme ? _gpnTheme.theme : _evaransharkTheme.theme;
  StyleRepo._() : useGPNTheme = true;

  static StyleRepo? _instance;

  factory StyleRepo() => _instance ??= StyleRepo._();

  void changeTheme(bool value) {
    useGPNTheme = value;
    notifyListeners();
  }
}
