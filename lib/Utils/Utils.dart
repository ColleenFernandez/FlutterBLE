import 'package:fble/Assets/AppColors.dart';
import 'package:fble/Common/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  static getLEDColor (int status) {
    if (status == Constants.CONNECTING)
      return AppColors.yellowLEDColor;

    if (status == Constants.CONNECTED)
      return AppColors.greenLEDColor;

    return AppColors.redLEDColor;
  }

  static Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return AppColors.greenLEDColor;
    }
    return AppColors.greenLEDColor;
  }
}