import 'package:fble/Common/Constants.dart';
import 'package:flutter/services.dart';

class Common {
  static final platform = MethodChannel(Constants.NATIVE_CODE_CHANNEL);
}