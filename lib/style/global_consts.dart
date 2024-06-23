import 'package:flutter/material.dart';

class GlobalStyleVariables {
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _screenSpacer;

  Future<void> setScreenDimensions(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    _screenHeight = screenSize.height;
    _screenWidth = screenSize.width;
    if (_screenHeight > _screenWidth) {
      _screenSpacer = _screenHeight;
    } else {
      _screenSpacer = _screenWidth;
    }
    return Future.value();
  }

  static TextStyle textWhite = const TextStyle(color: Colors.white);

  static double get screenSpacer => _screenSpacer;
  static double get screenHeight => _screenHeight;
  static double get screenWidth => _screenWidth;
}
