import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:NewsApp/constants/Constants.dart';
import 'package:NewsApp/events/ChangeThemeEvent.dart';
import 'package:NewsApp/util/DataUtils.dart';
import 'package:NewsApp/util/ThemeUtils.dart';
import 'package:NewsApp/model/local/Nav.dart';
import 'pages/HomePage.dart';
import 'pages/MyInfoPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
   //初始化频道数据的容器
  List<Nav> navs;
  final appBarTitles = ['首页', '我的'];
  // final tabTextStyleSelected = TextStyle(color: const Color(0xff63ca6c));
  final tabTextStyleSelected = TextStyle(color: Colors.blue);
  final tabTextStyleNormal = TextStyle(color: const Color(0xff969696));

  Color themeColor = ThemeUtils.currentColorTheme;
  int _tabIndex = 0;

  var tabImages;
  var _body;
  var pages;

  Image getTabImage(path) {
    return Image.asset(path, width: 20.0, height: 20.0);
  }

  @override
  void initState() {
    super.initState();
    DataUtils.getColorThemeIndex().then((index) {
      print('color theme index = $index');
      if (index != null) {
        ThemeUtils.currentColorTheme = ThemeUtils.supportColors[index];
        Constants.eventBus.fire(ChangeThemeEvent(ThemeUtils.supportColors[index]));
      }
    });
    Constants.eventBus.on<ChangeThemeEvent>().listen((event) {
      setState(() {
        themeColor = event.color;
      });
    });
    pages = <Widget>[HomePage(), MyInfoPage()];
    if (tabImages == null) {
      tabImages = [
        [
          getTabImage('images/nav/home_nor.png'),
          getTabImage('images/nav/home_pre.png')
        ],
        [
          getTabImage('images/nav/mine_nor.png'),
          getTabImage('images/nav/mine_pre.png')
        ]
      ];
    }
  }

  TextStyle getTabTextStyle(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabTextStyleSelected;
    }
    return tabTextStyleNormal;
  }

  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  Text getTabTitle(int curIndex) {
    return Text(appBarTitles[curIndex], style: getTabTextStyle(curIndex));
  }

  @override
  Widget build(BuildContext context) {
    _body = IndexedStack(
      children: pages,
      index: _tabIndex,
    );
    return MaterialApp(
      theme: ThemeData(
          primaryColor: themeColor
      ),
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text(appBarTitles[_tabIndex],
        //   style: TextStyle(color: Colors.black)),
        //   iconTheme: IconThemeData(color: Colors.black)
        // ),
        body: _body,
        bottomNavigationBar: CupertinoTabBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: getTabIcon(0),
                title: getTabTitle(0)),
            BottomNavigationBarItem(
                icon: getTabIcon(1),
                title: getTabTitle(1)),
          ],
          currentIndex: _tabIndex,
          onTap: (index) {
            setState((){
              _tabIndex = index;
            });
          },
        )
        // drawer: MyDrawer()
      ),
    );
  }
}
