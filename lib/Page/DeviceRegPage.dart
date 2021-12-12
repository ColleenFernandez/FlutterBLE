
import 'dart:convert';

import 'package:fble/Assets/AppColors.dart';
import 'package:fble/Common/Common.dart';
import 'package:fble/Common/Constants.dart';
import 'package:fble/Model/DeviceModel.dart';
import 'package:fble/Model/NativeComModel.dart';
import 'package:fble/Page/DeviceSettingPage.dart';
import 'package:fble/Utils/LogUtils.dart';
import 'package:fble/Utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';

class DeviceRegPage extends StatefulWidget{
  @override
  State<DeviceRegPage> createState() => _DeviceRegPageState();
}

class _DeviceRegPageState extends State<DeviceRegPage> {

  List<DeviceModel> allDeviceList = [];
  List<DeviceModel> registeredDevices = [];
  bool isScanning = false;
  NativeComModel nativeComModel = new NativeComModel();

  @override
  void initState() {
    super.initState();

  }

  Future<void> scanDevice() async {
    try {
      nativeComModel.command = Constants.SCAN_DEVICE;
      nativeComModel.passValue = '';

      final res = await Common.platform.invokeMethod(jsonEncode(nativeComModel.toJSON()));

      LogUtils.log('res ===> ${res}');

      allDeviceList.clear();
      allDeviceList.addAll(DeviceModel().getList(jsonDecode(res)));

    }on PlatformException catch (e) {
      LogUtils.log('error ==> ${e.toString()}');
    }

    isScanning = false;
    setState(() {});
  }

  Future<void> connectDevice(DeviceModel model, int index) async {
    try {
      nativeComModel.command = Constants.CONNECT_DEVICE;
      nativeComModel.passValue = model.address;

      final res = await Common.platform.invokeMethod(jsonEncode(nativeComModel.toJSON()));

      LogUtils.log('res ===> ${res}');

    }on PlatformException catch (e) {
      LogUtils.log('error ==> ${e.toString()}');
    }

    allDeviceList[index].isConnecting = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity, height: 100,
              padding: EdgeInsets.only(top: 30),
              color: AppColors.menuBgColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(), Spacer(),
                  Icon(Icons.system_security_update_good_outlined, color: Colors.white, size: 30,),
                  SizedBox(width: 10,),
                  Text('登録デバイス一覧', style: TextStyle(color: Colors.white, fontSize: 20),),
                  SizedBox(width: 20,),
                  Container(
                    width: 100, height: 50,
                    child: Stack(
                      children: [
                        isScanning == true ? Align(
                            child: Container(width: 30, height: 30, child: CircularProgressIndicator(color: AppColors.greenLEDColor,),
                              alignment: Alignment.centerRight,))
                            : TextButton(onPressed: () {
                              scanDevice();
                              setState(() {
                                isScanning = true;
                              });
                        } , child: Text('スキャン', style: TextStyle(fontSize: 18),)),
                      ],
                    ),
                  )
                ],
              ),
            ),

            // Registered device
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.only(left: 20),
              width: double.infinity, height: 65,
              color: AppColors.menuBgColor,
              child: Row(
                children: [
                  Text('登録済みのデバイス', style: TextStyle(color: Colors.white, fontSize: 20),)
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2 - 150,
              child: ListView.separated(
                  padding: EdgeInsets.only(top: 1),
                  itemBuilder: (context, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      color: AppColors.menuBgColor,
                      child: Row(
                        children: [
                          Container(
                            width: 20, height: 20,
                            margin: EdgeInsets.only(left: 15, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Utils.getLEDColor(allDeviceList[index].status),
                              boxShadow:[
                                BoxShadow(
                                    color: Utils.getLEDColor(allDeviceList[index].status),
                                    blurRadius: 7.0,
                                    offset: Offset(0.0, 0.75)
                                )
                              ],
                            ),
                          ),
                          Text(allDeviceList[index].name, style: TextStyle(color: Colors.white, fontSize: 16),),
                          Spacer(),
                          GFCheckbox(
                              size: 25,
                              inactiveBorderColor: Colors.white,
                              inactiveBgColor: Colors.transparent,
                              activeBgColor: AppColors.greenLEDColor,
                              onChanged: (value) {
                                setState(() {
                                  allDeviceList[index].isScreenSharing = value;
                                });
                              },
                              value: allDeviceList[index].isScreenSharing),
                          SizedBox(width: 5,),
                          Text('sharing\nscreen', style: TextStyle(color: allDeviceList[index].isScreenSharing ? Colors.white : Colors.transparent),),
                          IconButton(onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DeviceSettingPage(allDeviceList[index])));
                          }, icon: Icon(Icons.settings_outlined, color: Colors.white,))
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Container(width: double.infinity, height: 0.5, color: AppColors.bgColor,);
                  },
                  itemCount: allDeviceList.length),
            ),

            // other devices
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(left: 20),
              width: double.infinity, height: 65,
              color: AppColors.menuBgColor,
              child: Row(
                children: [
                  Text('その他のデバイス', style: TextStyle(color: Colors.white, fontSize: 20),)
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2 - 180,
              child: ListView.separated(
                  padding: EdgeInsets.only(top: 1),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(left: 30, right: 10),
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      color: AppColors.menuBgColor,
                      child: Row(
                        children: [
                          Text(allDeviceList[index].name, style: TextStyle(color: Colors.white, fontSize: 16),),
                          Spacer(),
                          Container(
                            width: 100, height: 50,
                            child: Stack(
                              children: [
                                allDeviceList[index].isConnecting == true ? Align(
                                    child: Container(width: 30, height: 30, child: CircularProgressIndicator(color: AppColors.greenLEDColor,),
                                      alignment: Alignment.centerRight,))
                                    : TextButton(onPressed: () {
                                  connectDevice(allDeviceList[index], index);
                                  setState(() {
                                    allDeviceList[index].isConnecting = true;
                                  });
                                } , child: Text('接続する', style: TextStyle(color: Colors.grey),)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Container(width: double.infinity, height: 0.5, color: AppColors.bgColor,);
                  },
                  itemCount: allDeviceList.length),
            ),
          ],
        ),
      ),
    );
  }
}