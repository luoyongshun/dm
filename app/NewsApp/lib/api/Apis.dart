import 'package:NewsApp/constants/Constants.dart';
import 'package:NewsApp/events/BeanEvent.dart';
import 'package:NewsApp/model/network/NewsList.dart';
import 'package:NewsApp/util/HttpUtil.dart';
import 'Network.dart';
import 'dart:convert';

/* 网络请求API*/
class API$Neteast {
  //1. 请求新闻列表接口
  getNewsList(String type, String id, int startPage){
    print("进入请求");
    // String url = 'http://v.juhe.cn/toutiao/index?type=keji&key=4c52313fc9247e5b4176aed5ddd56ad7';
    String url = 'nc/article/$type/$id/$startPage-20.html';
    // String url = 'http://kpi.wanpinghui.com/api/getUserList';
    HttpUtil.get(
      url,
      data: {
        'id': id,
        'startPage': startPage,
      },
      // headers: {
        // 'Access-Control-Allow-Origin' : '*',
        // 'Accept' : 'application/json, text/plain, */*',
        // 'Content-Type' : 'application/json',
        // 'Authorization' : '**',
      // },
      success: (data){
        print("返回成功数据");
        print(data);
        if (data != null) {
          Map<String, dynamic> map = json.decode(data.date);
          Constants.eventBus.fire(BeanEvent<NewsList>(id, NewsList.fromJson(id, map)));
        }
      },error: (errorMsg){
        print("请求失败,返回失败信息");
        print(errorMsg);
      }
    );

    // String url = NetWork.NETEAST_HOST + 'nc/article/$type/$id/$startPage-20.html';
    // NetWork.get(url).then((data) {
    //   if (data != null) {
    //     Map<String, dynamic> map = json.decode(data);
    //     Constants.eventBus.fire(BeanEvent<NewsList>(id, NewsList.fromJson(id, map)));
    //   }
    // });

  }
  
  //2. 请求新闻内容详情接口
  getNewsDetail(String postId){
    String url = NetWork.NETEAST_HOST + 'nc/article/nc/article/$postId/full.html';
    NetWork.get(url).then((data) {
      if (data != null) {
        Map<String, dynamic> map = json.decode(data);
        Constants.eventBus.fire(BeanEvent<NewsList>(postId, NewsList.fromJson(postId, map)));
      }
    });
  }
}

/* 新浪新闻网络请求API*/
class API$Sina {}

/* 天气信息的网络请求API*/
class API$Weather {}
