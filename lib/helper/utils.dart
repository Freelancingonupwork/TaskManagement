
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast({required String Msg}) async {
  await Fluttertoast.showToast(
    msg: Msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM_RIGHT,
    timeInSecForIosWeb: 3,
    backgroundColor: Colors.blue,
    textColor: Colors.white,
    fontSize: 14.0,
  );
}