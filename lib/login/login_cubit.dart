import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit():super(LoginInitialState());
  static LoginCubit get(context)=> BlocProvider.of(context);

  IconData suffix =Icons.visibility_outlined;
 bool isSeen=true;
void changeVisibility(){
  isSeen= !isSeen;
  suffix= isSeen? Icons.visibility_outlined:Icons.visibility_off_outlined ;
  print('Hello $isSeen');
  emit(LoginVisibilityState());
}

void userLogin(
  {
  required String email,
  required String password,
}
    )

{
  emit(LoginLoadingState());
  FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password)
  .then((value) {

    emit(LoginSuccessState(value.user!.uid));
  })
      .catchError((error){
        print('Error is ${error.toString()}');
    emit(LoginErrorState(error.toString()));
  });
}
}