import 'package:flutter/cupertino.dart';

class MenuModel {
  AssetImage? icon;
  String name = '';
  bool isSelected = false;

  MenuModel(this.icon, this.name, this.isSelected);
}