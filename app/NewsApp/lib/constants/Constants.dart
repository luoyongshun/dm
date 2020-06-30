import 'package:event_bus/event_bus.dart';

class Constants {
  static final String redirectUrl = "http://osc.yubo.me/logincallback";

  static final String loginUrl = "https://www.oschina.net/action/oauth2/authorize?client_id=4rWcDXCNTV5gMWxtagxI&response_type=code&redirect_uri=" + redirectUrl;

  static final String oscClientID = "4rWcDXCNTV5gMWxtagxI";

  static final String endLineTag = "COMPLETE";

  static final EventBus eventBus = new EventBus();

  //网易新闻
  static const int TYPE_NET_NETEASE_NEWS = 1;
  //新浪新闻
  static const int TYPE_NET_SINA_NEWS = 2;
  //天气查询
  static const int TYPE_NET_WEATHER_INFO = 3;

  //当前的主题模式
  static int currentTheme = dayTheme;
  //日间模式
  static final int dayTheme = 1;
  //夜间模式
  static final int nightTheme = 2;
}

class Strings {
  //APP标题
  static final String appTitle = '搜索';
  static final String newsDetail = '新闻详情';
  static final String projectAdress = '项目地址';

  //作者
  static final String author = 'ChristianChen';
  //github
  static final String github = 'https://github.com/freestyletime';
  //des
  static final String des = '显示屏行业资讯头条';
}