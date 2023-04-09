import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/register/register_states.dart';
import 'package:socialapp/model/user_data_model.dart';


class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit(): super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password)
        .then((value) {
      userCreate(
          email: email,
          phone: phone,
          name:  name,
          uId: value.user!.uid);
    })
        .catchError((error) {
      print('Error is ${error.toString()}');
      emit(RegisterErrorState(error.toString()));
    });
  }

 ///**************************************
  UserModel? model;
  //I changed this
  void userCreate ({
    required String email,
    required String phone,
    required String name,
    required String uId,

  }) {

    UserModel  model = UserModel(
      name: name,
      phone: phone,
      email: email,
      uId: uId,
      image: "",
      bio: "Write your bio...",
      isEmailVerified: false
    ); //to this. it was model=UserModel();
    FirebaseFirestore.instance.collection('users').doc(uId)
        .set(model.toMap())
        .then((value) {
          emit(RegisterCreateUserSuccessState(uId));
    })
        .catchError((error){
          print('Error is ${error.toString()}');
      RegisterCreateUserErrorState(error.toString());
    });
  }
}