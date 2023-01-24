import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapp/login/login-screen.dart';
import 'package:socialapp/shared/cache_helper.dart';

void navigateTo(context,page)=> Navigator.push(context, MaterialPageRoute(builder:(context)=>page));
void navigateAndFinish(context,page)=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>page), (route) => false);
void showToast ({
  required String text,
  required ToastStates state
})=> Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates {SUCCESS,ERROR,WARNING}

Color chooseToastColor(ToastStates state){

  Color color;
  switch(state) {
    case ToastStates.SUCCESS: color= Colors.green;
    break;
    case ToastStates.ERROR: color= Colors.red;
    break;
    case ToastStates.WARNING: color= Colors.amber;
    break;

  }
  return color;
}

void signOut(context){
  CacheHelper.removeData(key:'uId').then((value){
    if(value){navigateAndFinish(context, LoginScreen());}
  });
}
String? uId;