import 'package:fble/Common/APIConsts.dart';

class DeviceModel {
  int status = 0;
  String name = '';
  String address = '';
  bool isScreenSharing = false;
  bool isRegistered = false;
  bool isConnecting = false;

  DeviceModel();

  factory DeviceModel.fromJSON(Map<String, dynamic> res) {
    DeviceModel model = new DeviceModel();

    model.name = res[APIConsts.name];
    model.address = res[APIConsts.address];

    return model;
  }

  List<DeviceModel> getList(List<dynamic> res) {
    List<DeviceModel> allData = [];
    res.forEach((element) {
      DeviceModel model = DeviceModel.fromJSON(element);
      allData.add(model);
    });

    return allData;
  }
}