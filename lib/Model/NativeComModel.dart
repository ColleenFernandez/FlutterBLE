import 'package:fble/Common/APIConsts.dart';

class NativeComModel {
  String command = '';
  String passValue = '';

  NativeComModel();

  factory NativeComModel.fromJSON(Map<String, dynamic> res){
    NativeComModel model = new NativeComModel();
    model.command = res[APIConsts.command];
    model.passValue = res[APIConsts.passValue];

    return model;
  }

  Map<String, dynamic> toJSON() => {
    APIConsts.command : command,
    APIConsts.passValue : passValue
  };
}