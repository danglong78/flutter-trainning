import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  ErrorDialog(this.message, {Key? key}) : super(key: key);
  String message;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.30;
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: height,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, height * 0.3, 10, 10),
                child: Column(
                  children: [
                    Text(
                      'Error !!!',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '$message',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.redAccent,
                      child: Text(
                        'Okay',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                top: -60,
                child: CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  radius: height * 0.2,
                  child: Icon(
                    Icons.assistant_photo,
                    color: Colors.white,
                    size: height * 0.2,
                  ),
                )),
          ],
        ));
  }
}
