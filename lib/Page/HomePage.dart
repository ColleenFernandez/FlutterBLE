import 'package:battery_indicator/battery_indicator.dart';
import 'package:fble/Assets/AppColors.dart';
import 'package:fble/Assets/Assets.dart';
import 'package:fble/Common/Constants.dart';
import 'package:fble/CustomWidget/CustomClipPath.dart';
import 'package:fble/CustomWidget/StsImgView.dart';
import 'package:fble/CustomWidget/TooltipShapeBorder.dart';
import 'package:fble/Model/DeviceModel.dart';
import 'package:fble/Model/MenuModel.dart';
import 'package:fble/Model/SettingModel.dart';
import 'package:fble/Utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:segment_display/segment_display.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{

  List<DeviceModel> deviceList = [];
  List<SettingModel> settingList = [];
  List<MenuModel> menuList = [];
  late TabController settingTabController;
  int selectedTab = 0, pageCnt = 0, menuCnt = 0;
  final PageController pageviewController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

    settingTabController = TabController(length: 3, vsync: this);

    loadData();
  }

  void loadData() {
    DeviceModel item1 = new DeviceModel(Constants.CONNECTED, 'AAAA-AAAA', true);
    DeviceModel item2 = new DeviceModel(Constants.CONNECTING, 'BBBB-BBBB', false);
    DeviceModel item3 = new DeviceModel(Constants.CUT_OFF, 'CCCC-CCCC', false);
    DeviceModel item4 = new DeviceModel(Constants.CUT_OFF, 'DDDD-DDDD', false);
    DeviceModel item5 = new DeviceModel(Constants.CUT_OFF, 'EEEE-EEEE', false);
    deviceList.add(item1); deviceList.add(item2); deviceList.add(item3); deviceList.add(item4); deviceList.add(item5);
    
    SettingModel model1 = new SettingModel('設定1', true);
    SettingModel model2 = new SettingModel('設定2', false);
    SettingModel model3 = new SettingModel('設定3', false);
    /*SettingModel model4 = new SettingModel('設定4', false);
    SettingModel model5 = new SettingModel('設定5', false);*/
    settingList.add(model1); settingList.add(model2); settingList.add(model3);// settingList.add(model4); settingList.add(model5);

    MenuModel menu1 = new MenuModel(Assets.IC_CLOCK, '時計', false);
    MenuModel menu2 = new MenuModel(Assets.IC_SMS, 'SMS', false);
    MenuModel menu3 = new MenuModel(Assets.IC_SNS, 'SNS', false);
    MenuModel menu4 = new MenuModel(Assets.IC_MAIL, 'メール', false);
    MenuModel menu5 = new MenuModel(Assets.IC_NEWS, 'ニュース', false);
    MenuModel menu6 = new MenuModel(Assets.IC_NOTI, '通知', false);
    MenuModel menu7 = new MenuModel(Assets.IC_MAP, 'マップ', false);
    MenuModel menu8 = new MenuModel(Assets.IC_PHOTO, 'フォト', false);
    MenuModel menu9 = new MenuModel(Assets.IC_TIMETABLE, '時刻表', false);
    MenuModel menu10 = new MenuModel(Assets.IC_CALENDAR, 'カレンダー', false);
    MenuModel menu11 = new MenuModel(Assets.IC_NOTEPAD, 'メモ帳', false);
    MenuModel menu12 = new MenuModel(Assets.IC_BATTERY, 'バッテリー', false);
    menuList.add(menu1); menuList.add(menu2); menuList.add(menu3); menuList.add(menu4); menuList.add(menu5); menuList.add(menu6);
    menuList.add(menu7); menuList.add(menu8); menuList.add(menu9); menuList.add(menu10); menuList.add(menu11); menuList.add(menu12);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 50),
              color: AppColors.menuBgColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Device List', style: TextStyle(color: Colors.white, fontSize: 20),),
                  Container(
                    width: MediaQuery.of(context).size.width, height: 60,
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child: Center(
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: deviceList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 30, height: 30, margin: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Utils.getLEDColor(deviceList[index].status),
                                boxShadow:[
                                  BoxShadow(
                                      color: Utils.getLEDColor(deviceList[index].status),
                                      blurRadius: 7.0,
                                      offset: Offset(0.0, 0.75)
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 40,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: settingList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            selectedTab = index;
                            for (int i = 0; i < settingList.length; i++){
                              settingList[i].isSelected = false;
                            }
                            settingList[selectedTab].isSelected = true;
                            setState(() {});
                          },
                          child: Container(
                            height: 40,
                            padding: EdgeInsets.only(left: 25, right: 25),
                            margin: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: Colors.white),
                              color: settingList[index].isSelected ? AppColors.greenLEDColor : Colors.transparent
                            ),
                            child: Center(child: Text(settingList[index].name, style: TextStyle(color: settingList[index].isSelected ? Colors.black : Colors.white),)),
                          ),
                        );
                      })
                ),
                IconButton(onPressed: () {

                }, icon: Icon(Icons.add_circle, color: Colors.blue,))
              ],
            ),
            Container(
              color: AppColors.darkBlue,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.only(top: 15, bottom: 20),
              child: Column (
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageIcon(Assets.IC_ARROW_UP, size: 20, color: AppColors.greenLEDColor,),
                      SizedBox(width: 10,),
                      Text('Sharing Screen', style: TextStyle(color: AppColors.greenLEDColor, fontSize: 18),)
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 10,
                        child: Column (
                          children: [
                            SevenSegmentDisplay(
                              backgroundColor: Colors.transparent,
                              value: '12:57', size: 6,
                              segmentStyle: HexSegmentStyle(
                                enabledColor: AppColors.greenLEDColor,
                                disabledColor: Colors.transparent,
                              ),
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('25%', style: TextStyle(color: AppColors.greenLEDColor, fontSize: 20),),
                                SizedBox(width: 10,),
                                BatteryIndicator(
                                  style: BatteryIndicatorStyle.skeumorphism,
                                  colorful: false,
                                  batteryLevel: 25,
                                  ratio: 2.5,
                                  size: 30,
                                  mainColor: AppColors.greenLEDColor,
                                  showPercentNum: false,
                                  showPercentSlide: true,
                                  batteryFromPhone: false,
                                )
                              ],
                            ),
                            SizedBox(height: 20,),
                            Container(
                              width: double.infinity, height: 100,
                              margin: EdgeInsets.only(left: 20, right: 20),
                              padding: EdgeInsets.all(10),
                              decoration: ShapeDecoration(
                                color: AppColors.greenLEDColor,
                                shape: TooltipShapeBorder(arrowArc: 0.1),
                                shadows: [
                                  BoxShadow(
                                      color: Colors.black26, blurRadius: 4.0, offset: Offset(2, 2))
                                ],
                              ),
                              child: Text('Aisha\n牛乳買ってきてね!'),
                            ),
                            SizedBox(height: 20,),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        child: Column(
                          children: [
                            StsImgView(image: Assets.IMG_PHOTO, width: double.infinity, height: 130),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color: AppColors.greenLEDColor)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10,),
                                  Center(child: Text('MEMO', style: TextStyle(color: AppColors.greenLEDColor),)),
                                  Container(
                                    width: double.infinity, height: 1, color: AppColors.greenLEDColor,
                                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 3),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20, right: 20),
                                    child: Text('・ 旅行準備', style: TextStyle(color: AppColors.greenLEDColor,)
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20, right: 20),
                                    child: Text('・ 買い物', style: TextStyle(color: AppColors.greenLEDColor,)
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                                    child: Text('・ 牛乳を買っていく', style: TextStyle(color: AppColors.greenLEDColor,)
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 250,
              child: PageView.builder(
                itemCount: (menuList.length / 12).toInt(),
                  controller: pageviewController,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, pageIndex) {
                    return GridView.builder(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                        shrinkWrap: true,
                        itemCount: 12,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 10,
                          crossAxisCount: 4,
                        ),
                        itemBuilder: (context, index) {
                          int menuIndex = pageIndex * 12 + index;
                          return InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              setState(() {
                                menuList[menuIndex].isSelected = !menuList[menuIndex].isSelected;
                              });
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: 60, height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                    boxShadow:[
                                      BoxShadow(
                                          color: menuList[menuIndex].isSelected ? AppColors.greenLEDColor.withAlpha(60) : Colors.transparent,
                                          blurRadius:10.0,
                                          offset: Offset(10, 10)
                                      )
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Column(
                                    children: [
                                      ImageIcon(menuList[menuIndex].icon, color: menuList[index].isSelected ? Colors.white : Colors.grey.withAlpha(90), size: 40,),
                                      Text(menuList[menuIndex].name, style: TextStyle(color: menuList[index].isSelected ? Colors.white :  Colors.grey.withAlpha(90)),)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
              }),
            ),
            SizedBox(height: 10,),
            SmoothPageIndicator(
                controller: pageviewController,  // PageController
                count:  (menuList.length / 12 ).toInt(),
                effect:  WormEffect(
                  dotWidth: 10, dotHeight: 10,
                  dotColor: Colors.grey,
                  activeDotColor: AppColors.greenLEDColor
                ),  // your preferred effect
                onDotClicked: (index){}
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}