import 'package:fble/Common/Constants.dart';
import 'package:fble/Model/DeviceModel.dart';
import 'package:fble/Utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import '../Assets/AppColors.dart';


class DeviceRegPage extends StatefulWidget{
  @override
  State<DeviceRegPage> createState() => _DeviceRegPageState();
}

class _DeviceRegPageState extends State<DeviceRegPage> {

  List<DeviceModel> deviceList = [];

  @override
  void initState() {
    super.initState();

    loadDeviceList();
  }

  void loadDeviceList() {
    DeviceModel item1 = new DeviceModel(Constants.CONNECTED, 'AAAA-AAAA', true);
    DeviceModel item2 = new DeviceModel(Constants.CONNECTING, 'BBBB-BBBB', false);
    DeviceModel item3 = new DeviceModel(Constants.CUT_OFF, 'CCCC-CCCC', false);
    deviceList.add(item1); deviceList.add(item2); deviceList.add(item3);
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
                  Icon(Icons.system_security_update_good_outlined, color: Colors.white, size: 30,),
                  SizedBox(width: 10,),
                  Text('登録デバイス一覧', style: TextStyle(color: Colors.white, fontSize: 20),)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.only(left: 20),
              width: double.infinity, height: 60,
              color: AppColors.menuBgColor,
              child: Row(
                children: [
                  Text('登録済みのデバイス', style: TextStyle(color: Colors.white, fontSize: 20),)
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2 - 100,
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
                              color: Utils.getLEDColor(deviceList[index].status),
                              boxShadow:[
                                BoxShadow(
                                    color: Utils.getLEDColor(deviceList[index].status),
                                    blurRadius: 7.0,
                                    offset: Offset(0.0, 0.75)
                                )
                              ],
                            ),
                          ),
                          Text(deviceList[index].name, style: TextStyle(color: Colors.white, fontSize: 16),),
                          Spacer(),
                          GFCheckbox(
                            size: 25,
                            inactiveBorderColor: Colors.white,
                            inactiveBgColor: Colors.transparent,
                            activeBgColor: AppColors.greenLEDColor,
                              onChanged: (value) {
                                setState(() {
                                  deviceList[index].isScreenSharing = value;
                                });
                              },
                              value: deviceList[index].isScreenSharing),
                          SizedBox(width: 5,),
                          Text('sharing\nscreen', style: TextStyle(color: deviceList[index].isScreenSharing ? Colors.white : Colors.transparent),),
                          IconButton(onPressed: () {

                          }, icon: Icon(Icons.settings_outlined, color: Colors.white,))
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Container(width: double.infinity, height: 0.5, color: AppColors.bgColor,);
                  },
                  itemCount: deviceList.length),
            ),
          ],
        ),
      ),
    );
  }
}