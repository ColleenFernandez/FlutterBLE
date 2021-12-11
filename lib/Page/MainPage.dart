
import 'package:fble/Assets/AppColors.dart';
import 'package:fble/Page/DeviceRegPage.dart';
import 'package:fble/Page/HomePage.dart';
import 'package:fble/Page/SettingPage.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget{
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: [
          SettingPage(),
          HomePage(),
          DeviceRegPage()
        ],
      ),
      bottomNavigationBar: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width, height: 70, color: AppColors.menuBgColor,
            padding: EdgeInsets.only(top: 60),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3, height: MediaQuery.of(context).size.width / 3,
                  child: Visibility(
                    visible: selectedIndex == 0 ? true : false,
                    child: Center(
                      child: Container(
                        width: 50, height: 50,
                        decoration: BoxDecoration(
                          boxShadow:[
                            BoxShadow(
                                color: AppColors.greenLEDColor,
                                blurRadius:15.0,
                                offset: Offset(0.0, 0.75)
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3, height: MediaQuery.of(context).size.width / 3,
                  child: Visibility(
                    visible: selectedIndex == 1 ? true : false,
                    child: Center(
                      child: Container(
                        width: 50, height: 50,
                        decoration: BoxDecoration(
                          boxShadow:[
                            BoxShadow(
                                color: AppColors.greenLEDColor,
                                blurRadius:15.0,
                                offset: Offset(0.0, 0.75)
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3, height: MediaQuery.of(context).size.width / 3,
                  child: Visibility(
                    visible: selectedIndex == 2 ? true : false,
                    child: Center(
                      child: Container(
                        width: 50, height: 50,
                        decoration: BoxDecoration(
                          boxShadow:[
                            BoxShadow(
                                color: AppColors.greenLEDColor,
                                blurRadius:15.0,
                                offset: Offset(0.0, 0.75)
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 65,
            child: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(label: '設定',
                    icon: Icon(Icons.settings)),
                BottomNavigationBarItem(label: 'ホーム',
                    icon: Icon(Icons.home)),
                BottomNavigationBarItem(label: 'デバイス登録',
                    icon: Icon(Icons.app_registration)),
              ],
              elevation: 0,
              selectedIconTheme: IconThemeData(opacity: 0, size: 0),
              unselectedIconTheme: IconThemeData(opacity: 0.0, size: 0),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 15,
              unselectedFontSize: 15,
              backgroundColor: Colors.transparent,
              currentIndex: selectedIndex,
              onTap: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}