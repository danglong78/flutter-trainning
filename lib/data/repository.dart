import 'package:demo_retrofit_moor/data/local/database.dart';
import 'package:demo_retrofit_moor/data/local/dogs_dao.dart';
import 'package:demo_retrofit_moor/model/dog_model.dart';
import 'package:dio/dio.dart';

import 'api/api_service.dart';
import 'package:faker/faker.dart';

class Repository {
  static final instance = Repository._internal();

  Repository._internal();

  Future fetchAndSaveListDogs() async {
    var listBreed = await getListBreed();

    for (String breed in listBreed) {
      var listUrl = await getListImageUrl(breed);
      List<DogModel> listOfDogs = listUrl
          .map((url) => DogModel(
              breed, url, faker.lorem.sentence(), faker.person.name(), false))
          .toList();
      DogsDao.instance.insertMultiDogs(listOfDogs);
    }
  }

  Future<List<String>> getListBreed() async {
    try {
      var rs = await ApiService.instance.getListBreed();
      Map<String, dynamic> list = rs.data['message'];
      print(list.keys.toList());
      return list.keys.toList();
    } on DioError catch (err) {
      rethrow;
    }
    return [];
  }

  Future<List<dynamic>> getListImageUrl(String breed) async {
    try {
      var rs = await ApiService.instance.getListDogImageUrl(breed);
      List<dynamic> list = rs.data['message'];
      print(list);
      return list;
    } catch (err) {
      rethrow;
    }
    return [];
  }

  Future<List<Dog>> getData() {
    return DogsDao.instance.allDogs;
  }

  Future deleteAll() {
    return DogsDao.instance.deleteAll();
  }

  Future<List<Dog>> getDogs(int index, {int limit = 5}) {
    return DogsDao.instance.getDogs(index, limit);
  }
}
