import 'dart:io';

import 'package:demo_retrofit_moor/const.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'api_service.g.dart';

@RestApi(baseUrl: "https://86bf1712-71bd-42d6-b2b5-d4a0345e831a.mock.pstmn.io/")
abstract class ApiService {
  static final instance = ApiService._internal(getDio());

  factory ApiService._internal(Dio dio, {String baseUrl}) = _ApiService;
  factory ApiService.external(Dio dio, {String baseUrl}) = _ApiService;

  @POST("/login")
  Future<String> login();

  @GET("https://dog.ceo/api/breeds/list/all")
  Future<HttpResponse<dynamic>> getListBreed();

  @GET("https://dog.ceo/api/breed/{breed}/images/random/3")
  Future<HttpResponse<dynamic>> getListDogImageUrl(@Path("breed") String breed);

  @GET("https://fake.io/test")
  @Headers({'required': 'Token'})
  Future<dynamic> testAPIWithToken();

  @GET("https://fake.io/test")
  Future<dynamic> testAPIWithoutToken();

  @GET("https://fake.io/test2")
  @Headers({'required': 'Token'})
  Future<dynamic> testAPIWithExpiredToken();

  @GET("https://fake.io/getNewToken")
  Future<dynamic> getNewToken();

  @GET("https://fake.io/testWithoutTokenAndThenAddToken")
  Future<dynamic> testAPIWithoutTokenAndThenAddToken();

  @POST("https://api.imgur.com/3/upload")
  @Headers({'required': 'ClientID'})
  Future<dynamic> uploadImage(@Part(name: "image") File image);
}
