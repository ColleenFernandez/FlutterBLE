
import 'package:fble/Assets/AppColors.dart';
import 'package:fble/Model/DeviceModel.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class DeviceSettingPage extends StatefulWidget {

  DeviceModel deviceModel;

  DeviceSettingPage(this.deviceModel);

  @override
  State<DeviceSettingPage> createState() => _DeviceSettingPageState();
}

class _DeviceSettingPageState extends State<DeviceSettingPage> with TickerProviderStateMixin {

  late TabController powerOffTimeTabController, screenUpdateRateTabController;
  bool isDeviceUnregister = false, isFWUpdate = false, isBatterySync = false, isDeviceButtonPower = false;
  bool isSwitchDeviceScreenTab = false;

  double bright = 50;

  @override
  void initState() {
    super.initState();
    powerOffTimeTabController = TabController(length: 4, vsync: this);
    screenUpdateRateTabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.menuBgColor,
        elevation: 1,
        title: Row(
          children: [
            Icon(Icons.settings_outlined, color: Colors.white, size: 30,),
            SizedBox(width: 20,),
            Text(widget.deviceModel.name),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // power off time
            Container(
              width: double.infinity, height: 55,
              color: AppColors.menuBgColor,
              margin: EdgeInsets.only(top: 1),
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text('大きさ変更', style: TextStyle(color: Colors.white),),
                  Container(width: MediaQuery.of(context).size.width - 150, margin: EdgeInsets.only(left: 20),
                    child: TabBar(
                        isScrollable: false,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.greenLEDColor),
                        unselectedLabelColor: Colors.grey,
                        labelColor: Colors.black,
                        controller: powerOffTimeTabController,
                        onTap: (int tapPosition) {

                        },
                        tabs: <Widget>[
                          Text('なし'),
                          Text('5分'),
                          Text('10分'),
                          Text('15分')
                        ]
                    ),
                  )
                ],
              ),
            ),

            // screen update rate
            Container(
              width: double.infinity, height: 55,
              color: AppColors.menuBgColor,
              margin: EdgeInsets.only(top: 1),
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text('大きさ変更', style: TextStyle(color: Colors.white),),
                  Container(width: MediaQuery.of(context).size.width - 150, margin: EdgeInsets.only(left: 20),
                    child: TabBar(
                        isScrollable: false,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.greenLEDColor),
                        unselectedLabelColor: Colors.grey,
                        labelColor: Colors.black,
                        controller: screenUpdateRateTabController,
                        onTap: (int tapPosition) {

                        },
                        tabs: <Widget>[
                          Container(padding: EdgeInsets.only(top: 3) , child: Text('144 Hz')),
                          Container(padding: EdgeInsets.only(top: 3) , child: Text('240 Hz'),),
                          Container(padding: EdgeInsets.only(top: 3) , child: Text('360 Hz'),),
                        ]
                    ),
                  )
                ],
              ),
            ),

            // device unregister
            Container(
              width: double.infinity, height: 55,
              color: AppColors.menuBgColor,
              margin: EdgeInsets.only(top: 1),
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text('大きさ変更', style: TextStyle(color: Colors.white),),
                  Spacer(),
                  GFToggle(
                    onChanged: (value) {
                      setState(() {
                        isDeviceUnregister = value!;
                      });
                    },
                    value: isDeviceUnregister,
                    type: GFToggleType.ios,
                    duration: Duration(milliseconds: 300),
                    enabledTrackColor: AppColors.greenLEDColor,
                  ),
                  SizedBox(width: 20,)
                ],
              ),
            ),

            // brightness setting
            Container(
              width: double.infinity, height: 55,
              color: AppColors.menuBgColor,
              margin: EdgeInsets.only(top: 1),
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text('輝度設定', style: TextStyle(color: Colors.white),),
                  Spacer(),
                  Container(
                    width: MediaQuery.of(context).size.width - 150,
                    child: Slider(
                        activeColor: AppColors.greenLEDColor,
                        thumbColor: Colors.white,
                        inactiveColor: Colors.grey,
                        value: bright, min: 0, max: 100,
                        onChanged: (value) {
                          setState(() {
                            bright = value;
                          });
                        }),
                  ),
                  SizedBox(width: 10,)
                ],
              ),
            ),

            // FW update
            Container(
              width: double.infinity, height: 55,
              color: AppColors.menuBgColor,
              margin: EdgeInsets.only(top: 1),
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text('FWアップデート', style: TextStyle(color: Colors.white),),
                  Spacer(),
                  GFToggle(
                    onChanged: (value) {
                      setState(() {
                        isFWUpdate = value!;
                      });
                    },
                    value: isFWUpdate,
                    type: GFToggleType.ios,
                    duration: Duration(milliseconds: 300),
                    enabledTrackColor: AppColors.greenLEDColor,
                  ),
                  SizedBox(width: 20,)
                ],
              ),
            ),

            // Battery sync
            Container(
              width: double.infinity, height: 55,
              color: AppColors.menuBgColor,
              margin: EdgeInsets.only(top: 1),
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text('バッテリー同期', style: TextStyle(color: Colors.white),),
                  Spacer(),
                  GFToggle(
                    onChanged: (value) {
                      setState(() {
                        isBatterySync = value!;
                      });
                    },
                    value: isBatterySync,
                    type: GFToggleType.ios,
                    duration: Duration(milliseconds: 300),
                    enabledTrackColor: AppColors.greenLEDColor,
                  ),
                  SizedBox(width: 20,)
                ],
              ),
            ),

            // device button / power
            Container(
              width: double.infinity, height: 55,
              color: AppColors.menuBgColor,
              margin: EdgeInsets.only(top: 1),
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text('デバイスボタン / 電源', style: TextStyle(color: Colors.white),),
                  Spacer(),
                  GFToggle(
                    onChanged: (value) {
                      setState(() {
                        isDeviceButtonPower= value!;
                      });
                    },
                    value: isDeviceButtonPower,
                    type: GFToggleType.ios,
                    duration: Duration(milliseconds: 300),
                    enabledTrackColor: AppColors.greenLEDColor,
                  ),
                  SizedBox(width: 20,)
                ],
              ),
            ),

            // Switch device button / screen tab
            Container(
              width: double.infinity, height: 55,
              color: AppColors.menuBgColor,
              margin: EdgeInsets.only(top: 1),
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text('デバイスボタン / 画面タブ切り替え', style: TextStyle(color: Colors.white),),
                  Spacer(),
                  GFToggle(
                    onChanged: (value) {
                      setState(() {
                        isSwitchDeviceScreenTab= value!;
                      });
                    },
                    value: isSwitchDeviceScreenTab,
                    type: GFToggleType.ios,
                    duration: Duration(milliseconds: 300),
                    enabledTrackColor: AppColors.greenLEDColor,
                  ),
                  SizedBox(width: 20,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}