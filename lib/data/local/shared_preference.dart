import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static final SharedPreference instance = SharedPreference._internal();

  SharedPreference._internal();

  Future<SharedPreferences> get sharedPreferences async =>
      await SharedPreferences.getInstance();

  Future<String?> getToken() async {
    var prefs = await sharedPreferences;
    return prefs.getString("token");
  }

  Future saveToken(String token) async {
    var prefs = await sharedPreferences;
    return prefs.setString("token", token);
  }

  Future deleteToken() async {
    var prefs = await sharedPreferences;
    return prefs.remove("token");
  }

  Future addFile(File file) async {
    List<String> files;
    var prefs = await sharedPreferences;
    if (prefs.containsKey("uploadFile")) {
      files = prefs.getStringList("uploadFile")!;
      files.add(file.absolute.path);
    } else {
      files = [file.absolute.path];
    }
    await prefs.setStringList("uploadFile", files);
  }

  Future addFiles(List<File> files) async {
    List<String> list;
    var prefs = await sharedPreferences;
    if (prefs.containsKey("uploadFile")) {
      list = prefs.getStringList("uploadFile")!;
      list.addAll(files.map((e) => e.absolute.path));
    } else {
      list = [...files.map((e) => e.absolute.path)];
    }
    await prefs.setStringList("uploadFile", list);
  }

  Future<List<String>> getFiles() async {
    var prefs = await sharedPreferences;
    if (prefs.containsKey("uploadFile")) {
      var files = prefs.getStringList("uploadFile")!;
      return files;
    }
    return [];
  }

  Future removeFiles(List<File> file) async {
    var prefs = await sharedPreferences;
    if (prefs.containsKey("uploadFile")) {
      var files = prefs.getStringList("uploadFile")!;
      for (var item in file) {
        files.remove(item.absolute.path);
      }
      prefs.setStringList("uploadFile", files);
    }
  }
}
