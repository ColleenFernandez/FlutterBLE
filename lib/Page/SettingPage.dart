
import 'package:fble/Assets/AppColors.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>  with TickerProviderStateMixin{
  late TabController sizeTabController, languageTabController, weekdayTabController, expressTimeTabController;

  List<String> mailList = ['aaaaaaa@aaaaa', 'bbbbbbb@bbbbb'];

  @override
  void initState() {
    super.initState();

    sizeTabController = TabController(length: 3, vsync: this);
    languageTabController = TabController(length: 2, vsync: this);
    weekdayTabController = TabController(length: 7, vsync: this);
    expressTimeTabController = TabController(length: 2, vsync: this);
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
                  Icon(Icons.settings_outlined, color: Colors.white, size: 30,),
                  SizedBox(width: 10,),
                  Text('設定', style: TextStyle(color: Colors.white, fontSize: 20),)
                ],
              ),
            ),

            // calendar
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.only(left: 20),
              width: double.infinity, height: 60,
              color: AppColors.menuBgColor,
              child: Row(
                children: [
                  Icon(Icons.event_note_outlined, color: Colors.white, size: 30),
                  SizedBox(width: 10,),
                  Text('カレンダー', style: TextStyle(color: Colors.white, fontSize: 20),)
                ],
              ),
            ),
            Container(
              width: double.infinity, height: 45,
              color: AppColors.menuBgColor,
              margin: EdgeInsets.only(top: 1),
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text('大きさ変更', style: TextStyle(color: Colors.white),),
                  Container(width: 200, margin: EdgeInsets.only(left: 20),
                    child: TabBar(
                        isScrollable: true,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.greenLEDColor),
                        unselectedLabelColor: Colors.grey,
                        labelColor: Colors.black,
                        controller: sizeTabController,
                        onTap: (int tapPosition) {

                        },
                        tabs: <Widget>[
                          Text('大'),
                          Text('中'),
                          Text('小')
                        ]
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity, height: 45,
              color: AppColors.menuBgColor,
              margin: EdgeInsets.only(top: 1),
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text('言語', style: TextStyle(color: Colors.white),),
                  Container(width: 200, margin: EdgeInsets.only(left: 20),
                    child: TabBar(
                        isScrollable: true,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.greenLEDColor),
                        unselectedLabelColor: Colors.grey,
                        labelColor: Colors.black,
                        controller: languageTabController,
                        onTap: (int tapPosition) {

                        },
                        tabs: <Widget>[
                          Text('English'),
                          Text('日本語'),
                        ]
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: AppColors.menuBgColor,
              margin: EdgeInsets.only(top: 1),
              padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin : EdgeInsets.only(left: 10, bottom: 10),
                      child: Text('週の開始曜日', style: TextStyle(color: Colors.white),)),
                  Container(width: MediaQuery.of(context).size.width, margin: EdgeInsets.only(left: 10),
                    child: TabBar(
                        isScrollable: false,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.greenLEDColor),
                        unselectedLabelColor: Colors.grey,
                        labelColor: Colors.black,
                        controller: weekdayTabController,
                        onTap: (int tapPosition) {

                        },
                        tabs: <Widget>[
                          Text('日'),
                          Text('月'),
                          Text('火'),
                          Text('水'),
                          Text('木'),
                          Text('金'),
                          Text('土')
                        ]
                    ),
                  )
                ],
              ),
            ),

            // email
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.only(left: 20),
              width: double.infinity, height: 60,
              color: AppColors.menuBgColor,
              child: Row(
                children: [
                  Icon(Icons.email_outlined, color: Colors.white, size: 30),
                  SizedBox(width: 10,),
                  Text('メール', style: TextStyle(color: Colors.white, fontSize: 20),)
                ],
              ),
            ),
            Container(
              height: 92,
              child: ListView.separated(
                  padding: EdgeInsets.only(top: 1),
                  itemBuilder: (context, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      color: AppColors.menuBgColor,
                      child: Row(
                        children: [
                          SizedBox(width: 20,),
                          Visibility(
                            visible: index == 0, maintainAnimation: true, maintainSize: true, maintainState: true,
                            child: Text('アドレス', style: TextStyle(color: Colors.white),),
                          ),
                          SizedBox(width: 30),
                          Text('aaaaaaa@aaaaa', style: TextStyle(color: Colors.white),),
                          Spacer(),
                          IconButton(onPressed: () {

                          }, icon: Icon(Icons.keyboard_arrow_right_outlined, color: Colors.white,))
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Container(width: double.infinity, height: 0.5, color: AppColors.bgColor,);
                  },
                  itemCount: mailList.length),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 45,
              color: AppColors.menuBgColor,
              child: Row(
                children: [
                  SizedBox(width: 20,),
                  Text('アドレス', style: TextStyle(color: AppColors.menuBgColor)),
                  SizedBox(width: 30),
                  Text('メールアドレスの追加', style: TextStyle(color: Colors.white),),
                  Spacer(),
                  IconButton(onPressed: () {

                  }, icon: Icon(Icons.add_outlined, color: Colors.white,))
                ],
              ),
            ),

            // clock
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.only(left: 20),
              width: double.infinity, height: 60,
              color: AppColors.menuBgColor,
              child: Row(
                children: [
                  Icon(Icons.schedule_outlined, color: Colors.white, size: 30),
                  SizedBox(width: 10,),
                  Text('時計', style: TextStyle(color: Colors.white, fontSize: 20),)
                ],
              ),
            ),
            Container(
              width: double.infinity, height: 45,
              color: AppColors.menuBgColor,
              margin: EdgeInsets.only(top: 1),
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text('表示時間', style: TextStyle(color: Colors.white),),
                  Container(width: MediaQuery.of(context).size.width - 150, margin: EdgeInsets.only(left: 20),
                    child: TabBar(
                        isScrollable: false,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.greenLEDColor),
                        unselectedLabelColor: Colors.grey,
                        labelColor: Colors.black,
                        controller: expressTimeTabController,
                        onTap: (int tapPosition) {

                        },
                        tabs: <Widget>[
                          Text('24時間表記'),
                          Text('12時間表記')
                        ]
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}