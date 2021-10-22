import 'package:demo_retrofit_moor/bloc/dogs/dogs_bloc.dart';
import 'package:demo_retrofit_moor/custom_theme.dart';
import 'package:demo_retrofit_moor/provider/theme_provider.dart';
import 'package:demo_retrofit_moor/page/home/home_page.dart';
import 'package:demo_retrofit_moor/page/login/login_page.dart';
import 'package:demo_retrofit_moor/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      builder: (context, child) => MaterialApp(
        title: 'Flutter Demo',
        theme: Provider.of<ThemeProvider>(context).theme,
        debugShowCheckedModeBanner: false,
        home: ChangeNotifierProvider(
            create: (_) => LoginProvider(),
            child: Consumer<LoginProvider>(
              builder: (context, value, child) {
                return FutureBuilder<bool>(
                    future: value.isLogin,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data! == true) {
                          return BlocProvider(
                              create: (BuildContext context) => DogsBloc(),
                              child: const HomePage());
                        } else {
                          return const LoginPage();
                        }
                      } else {
                        return const CircularProgressIndicator();
                      }
                    });
              },
            )),
      ),
    );
  }
}
