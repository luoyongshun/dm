import 'package:dio/dio.dart';
import 'dart:async';

class BaseUrl{
  // 配置默认请求地址
  static const String url = 'http://c.m.163.com/';
}

class HttpUtil{
  static void get(
    String url,
    {
      Map<String, dynamic> data,
      Map<String, dynamic> headers,
      Function success,
      Function error
    }
  ) async {
    // 数据拼接
    if(data != null && data.isNotEmpty){
      StringBuffer options= new StringBuffer('?');
      data.forEach((key, value){
        options.write("$key" + "=" + "$value" + "&");
      });
      String optionsStr = options.toString();
      optionsStr = optionsStr.substring(0, optionsStr.length - 1);
      url += optionsStr;
    }
    // 发送get请求
    await _sendRequest(
        url,
        'get',
        success,
        data: data,
        headers: headers,
        error: error
    );
  }

  static void post(
    String url,
    {
      Map<String, dynamic> data,
      Map<String, dynamic> headers,
      Function success,
      Function error
    }
  ) async {

    // 发送post请求
    _sendRequest(
      url,
      'post',
      success,
      data: data,
      headers: headers,
      error: error
    );
  }

  // 请求处理
  static Future _sendRequest(
    String url,
    String method,
    Function success,
    {
      Map<String, dynamic> data,
      Map<String, dynamic> headers,
      Function error
    }
  ) async {
    int _code;
    String _msg;
    var _backData;

    // 检测请求地址是否是完整地址
    if(!url.startsWith('http')){
      url = BaseUrl.url + url;
    }
    print("打印请求参数");
    print(url);
    print(method);
    print(data);
    print(error);
    try{
      Map<String, dynamic> dataMap = data == null ? new Map() : data;
      Map<String, dynamic> headersMap = headers == null ? new Map() : headers;
      
      // 配置dio请求信息
      Response response;
      Dio dio = new Dio();
      // HttpClient httpClient = new HttpClient();
      // HttpClientRequest request;
      // HttpClientResponse response;
      dio.options.connectTimeout = 10000;        // 服务器链接超时，毫秒
      dio.options.receiveTimeout = 3000;         // 响应流上前后两次接受到数据的间隔，毫秒
      headersMap['Access-Control-Allow-Origin'] = '*';
      headersMap['Accept'] = 'application/json, text/plain, */*';
      headersMap['Content-Type'] = 'application/json';
      headersMap['Authorization'] = '**';
      headersMap['HZUID'] = '2';
      headersMap['User-Aagent'] = '4.1.0;android;6.0.1;default;A001;Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6);AppleWebKit/537.36 (KHTML, like Gecko);Chrome/83.0.4103.61 Safari/537.36';
      //headersMap['User-Aagent'] = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36';
      dio.options.headers.addAll(headersMap);    // 添加headers,如需设置统一的headers信息也可在此添加
     
      // Uri uri=Uri(scheme: "http",
      //             host: "c.m.163.com", 
      //             path: "/nc/article/headline/T1348647909107/0-20.html",
      //             // pathSegments: [],
      //             // queryParameters: dataMap,
      //         );
      // request.headers.add('User-Aagent', '4.1.0;android;6.0.1;default;A001;Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6);AppleWebKit/537.36 (KHTML, like Gecko);Chrome/83.0.4103.61 Safari/537.36');
      // request.headers.add('Access-Control-Allow-Origin', '*');
      // request.headers.add('Authorization', '**');
      // request.headers.add('Content-Type', 'application/json');
      // String payload = dataMap.toString();
      // request.add(utf8.encode(payload)); 
      Options options = Options(
        method: method,
        sendTimeout: 10000,
        receiveTimeout: 1000,
        headers: headersMap,
      );
      if(method == 'get'){
        print("开始进行请求dio");
        // print(headersMap);
        response = await dio.get(url, options: options);
        // response = await dio.get(url, queryParameters: dataMap, options: options);
        // response = await dio.getUri(uri, options: options);
        // request =  await httpClient.getUrl(uri);
        print("打印请求信息");
        print(response);
      }else{
        // request = await httpClient.postUrl(uri);
        response = await dio.post(url, data: dataMap);
      }
      // print("关闭请求");
      // response = await request.close();
      // print("打印返回信息");
      // print(response);
      // print("读取响应内容");
      // String  responseBody = await response.transform(utf8.decoder).join();
      // print(responseBody);
      // print("请求结束");
      // httpClient.close();
      
      if(response.statusCode != 200){
        _msg = '网络请求错误,状态码:' + response.statusCode.toString();
        _handError(error, _msg);
        return;
      }

      // 返回结果处理
      Map<String, dynamic> resCallbackMap = response.data;
      _code = resCallbackMap['code'];
      _msg = resCallbackMap['msg'];
      _backData = resCallbackMap['data'];

      if(success != null){
        if(_code == 0){
          success(_backData);
        }else{
          String errorMsg = _code.toString()+':'+_msg;
          _handError(error, errorMsg);
        }
      }

    }catch(e){
      _handError(error, '数据请求错误：'+e.toString());
    }
  }

  // 返回错误信息
  static Future _handError(Function errorCallback,String errorMsg){
    if(errorCallback != null){
      errorCallback(errorMsg);
      return null;
    }
    return null;
  }
}