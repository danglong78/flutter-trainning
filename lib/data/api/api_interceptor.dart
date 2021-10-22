import 'package:demo_retrofit_moor/const.dart';
import 'package:demo_retrofit_moor/data/api/api_service.dart';
import 'package:demo_retrofit_moor/data/local/shared_preference.dart';
import 'package:dio/dio.dart';
import 'dart:math';

class ApiInterceptor extends Interceptor {
  final Dio dio;
  ApiInterceptor(this.dio);
  // ApiInterceptor();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    if (options.headers.containsKey("required")) {
      if (options.headers["required"] == "Token") {
        String? token = await SharedPreference.instance.getToken();
        // if (token == null) {
        //   dio.interceptors.requestLock.lock();
        //   ApiService.instance.login().then((value) {
        //     options.headers['token'] = token;
        //   }).catchError((err, stackTrace) {
        //     handler.reject(err, true);
        //   }).whenComplete(() {
        //     dio.interceptors.requestLock.unlock();
        //   });
        // } else {
        options.headers['token'] = token;
        // }
      } else if (options.headers["required"] == "ClientID") {
        options.headers['Authorization'] = "Client-ID $clientID";
      }
    }
    switch (options.path) {
      case "https://fake.io/test":
        {
          if (options.headers.containsKey('token')) {
            return handler.resolve(
                Response(
                    requestOptions: options,
                    data: "Success User have token",
                    statusCode: 200),
                true);
          } else {
            return handler.reject(
                DioError(
                    requestOptions: options,
                    type: DioErrorType.response,
                    response: Response(
                        statusCode: 401,
                        data: "Token not found",
                        requestOptions: options)),
                true);
          }
        }
      case "https://fake.io/test2":
        {
          return handler.reject(
              DioError(
                  requestOptions: options,
                  type: DioErrorType.response,
                  response: Response(
                      statusCode: 401,
                      data: "Token expired",
                      requestOptions: options)),
              true);
        }
      case "https://fake.io/testWithoutTokenAndThenAddToken":
        {
          return handler.reject(
              DioError(
                  requestOptions: options,
                  type: DioErrorType.response,
                  response: Response(
                      statusCode: 401,
                      data: "Token not found",
                      requestOptions: options)),
              true);
        }
      default:
        break;
    }

    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {

    if (err.response != null) {
      if (err.response!.requestOptions.path == "https://fake.io/test") {
        return handler.resolve(
          Response(
              requestOptions: err.requestOptions,
              data: "Token not found",
              statusCode: 401),
        );
      } else if (err.response!.requestOptions.path == "https://fake.io/test2") {
        print("OLD TOKEN: ${err.requestOptions.headers['token']}");
        err.requestOptions.headers['token'] = "12312wdxczczxczzx";
        print("NEW TOKEN: ${err.requestOptions.headers['token']}");
        var rs = await ApiService.instance.testAPIWithToken();
        return handler.resolve(Response(
            requestOptions: err.requestOptions, data: rs, statusCode: 200));
      } else if (err.response!.requestOptions.path ==
          "https://fake.io/testWithoutTokenAndThenAddToken") {
        print("ADD Token to Header and retry");
        var rs = await ApiService.instance.testAPIWithToken();
        return handler.resolve(Response(
            requestOptions: err.requestOptions, data: rs, statusCode: 200));
      }
      return handler.next(err);
    }
    // else if (_shouldRetry(err)) {
    //   var requestOptions = err.requestOptions;
    //   print("Retry request");
    //   Dio().fetch(requestOptions).then((response) {
    //         print("retry sucess");
    //     handler.resolve(response);
    //   }).catchError((err) {
    //     print("retry fail $err");
    //     handler.reject(err);
    //   });
    // }
    else {
      return handler.next(err);
    }
  }
}
