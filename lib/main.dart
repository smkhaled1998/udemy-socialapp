import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/home/home_cubit.dart';
import 'package:socialapp/shared/bloc_observer.dart';
import 'package:socialapp/shared/cache_helper.dart';
import 'package:socialapp/shared/styles/styles.dart';

import 'home/home_layout.dart';
import 'login/login-screen.dart';
import 'shared/components.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  await CacheHelper.init();

  Widget? widget;
  uId = CacheHelper.getData(key: 'uId');

  if (uId != null) {
    widget = const HomeLayout();
  } else {
    widget = LoginScreen();
  }
  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  MyApp({Key? key, this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => HomeCubit()..getUserData(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightMode,
          home: startWidget),
    );
  }
}
