import 'package:NewsApp/constants/Constants.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class NetWork {
  static bool _debug = true;
  //网易新闻的host
  static String NETEAST_HOST = "http://c.m.163.com/";

  //新浪图片的host
  static String SINA_PHOTO_HOST = "http://api.sina.cn/sinago/";

  //天气预报host
  static String WEATHER_HOST = "http://wthrcdn.etouch.cn/";

  static String getHost(int type) {
    switch (type) {
      case Constants.TYPE_NET_NETEASE_NEWS:
        return NETEAST_HOST;
      case Constants.TYPE_NET_SINA_NEWS:
        return SINA_PHOTO_HOST;
      case Constants.TYPE_NET_WEATHER_INFO:
        return WEATHER_HOST;
      default:
        return '';
    }
  }

  /* 基础GET请求 */
  static Future<String> get(String url, {Map<String, String> params}) async {
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }
    http.Response res =
         await http.get(url,headers: getCommonHeader());
    
    print("状态：${res.statusCode}");
    print("正文：${res.body}");
    if (_debug) {
      print('_____________________');
      print('|发起Get请求|');
      print('|请求URL：$url|');
      print('|返回数据：${res.body}|');
      print('|_____________________|');
    }
    return res.toString();
  }

/* 基础POST请求 */
  static Future<String> post(String url, {Map<String, String> params}) async {
    http.Response res =
        await http.post(url, body: params, headers: getCommonHeader());
    if (_debug) {
      print('_____________________');
      print('|发起Post请求|');
      print('|请求URL：$url|');
      print('|请求数据：${params.toString()}|');
      print('|返回数据：${res.body}|');
      print('|_____________________|');
    }
    return res.body;
  }

  static Map<String, String> getCommonHeader() {
    Map<String, String> headers = Map();
    headers['Access-Control-Allow-Origin'] = '*';
    headers['Access-Control-Allow-Credentials'] = 'true';
    headers['Content-Type'] = 'application/json;charset=utf-8';
    headers['Accept'] = 'application/json';
    headers['Authorization'] = '**';
    headers['User-Agent'] =
        'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36';
    return headers;
  }
}
