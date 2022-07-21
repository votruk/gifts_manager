import 'package:flutter/material.dart';

extension BuildContextColors on BuildContext {
  Color dynamicPlainColor({
    required final Color lightThemeColor,
    required final Color darkThemeColor,
  }) {
    final brightness = MediaQuery.of(this).platformBrightness;
    switch (brightness) {
      case Brightness.dark:
        return darkThemeColor;
      case Brightness.light:
        return lightThemeColor;
    }
  }
}
