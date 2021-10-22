import 'package:demo_retrofit_moor/data/api/api_service.dart';
import 'package:flutter/material.dart';

class TestInterceptorPage extends StatelessWidget {
  const TestInterceptorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextButton(
                onPressed: () async {
                  var rs = await ApiService.instance.testAPIWithToken();
                  print(rs);
                },
                child: Text("Test API added token")),
            TextButton(
                onPressed: () async {
                  var rs = await ApiService.instance.testAPIWithoutToken();
                  print(rs);
                },
                child: Text("Test API without token")),
            TextButton(
                onPressed: () async {
                  var rs = await ApiService.instance.testAPIWithExpiredToken();
                  print(rs);
                },
                child: Text("Test API with expired token")),
            TextButton(
                onPressed: () async {
                  var rs = await ApiService.instance
                      .testAPIWithoutTokenAndThenAddToken();
                  print(rs);
                },
                child: Text(
                    "Test API without token and then retry with add token")),
          ],
        ),
      ),
    );
  }
}
