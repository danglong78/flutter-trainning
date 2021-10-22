import 'package:demo_retrofit_moor/data/api/dio_exception.dart';
import 'package:demo_retrofit_moor/provider/login_provider.dart';
import 'package:demo_retrofit_moor/widget/error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widget/loading_dialog.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  String password = "";
  String username = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).hintColor.withOpacity(0.2),
              offset: const Offset(0, 10),
              blurRadius: 20,
            )
          ]),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 85),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Login",
              style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              // cursorColor: Colors.red,
              validator: (value) =>
                  (value!.isEmpty) ? "Please input your username" : null,
              onSaved: (input) {
                username = input!.trim();
              },
              decoration: InputDecoration(
                hintText: "Username",
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.3))),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              obscureText: hidePassword,
              cursorColor: Theme.of(context).colorScheme.primary,
              validator: (value) =>
                  (value!.length < 8) ? "Password should be more than 8" : null,
              onSaved: (input) {
                password = input!.trim();
              },
              decoration: InputDecoration(
                  hintText: "Password",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.3))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary)),
                  suffixIcon: IconButton(
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(hidePassword ? 0.3 : 1.0),
                    icon: Icon(
                        hidePassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    final form = formKey.currentState;
                    if (form!.validate()) {
                      form.save();
                      double height = MediaQuery.of(context).size.height * 0.15;
                      double width = MediaQuery.of(context).size.width * 0.85;
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return LoadingDialog(height: height, width: width);
                        },
                      );
                      Provider.of<LoginProvider>(context, listen: false)
                          .login(username, password)
                          .then((value) {
                        Navigator.pop(context);
                      }).catchError((err) {
                        Navigator.pop(context);
                        switch (err.runtimeType) {
                          case DioError:
                            // Here's the sample to get the failed response error code and message
                            showDialog(
                              context: context,
                              builder: (context) => ErrorDialog(
                                  DioException.fromError(err).toString()),
                            );
                            break;
                          default:
                            final res = err.toString();
                            showDialog(
                              context: context,
                              builder: (context) => ErrorDialog(res),
                            );
                        }
                      });
                    }
                  },
                  child: Text(
                    "Login",
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 12.0)),
                ),
                const SizedBox(
                  width: 5,
                ),
                TextButton(
                  onPressed: () {
                    final form = formKey.currentState;
                    if (form!.validate()) {
                      form.save();
                    }
                  },
                  child: Text(
                    "Sign up",
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 12.0)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
