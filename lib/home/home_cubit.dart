import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:socialapp/home/home_states.dart';
import 'package:socialapp/home/settings/settings_screen.dart';
import 'package:socialapp/home/users/users_screen.dart';
import 'package:socialapp/model/post-model.dart';

import '../model/user_data_model.dart';
import '../shared/components.dart';
import 'chats/chats_screen.dart';

import 'create-post/create-post.dart';
import 'feeds/feeds_screen.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
/// **********IndexBottomNav********************/
  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    CreatePost(),
    UsersScreen(),
    SettingsScreen(),

  ];
  List<String> titles = ["News", "Chats","", "Users", "Settings"];
  void changeBottomNav(index) {

    if(index==2) {
      emit (NewPostState());
    } else {
      currentIndex = index;
      emit(ChangeBottomNavBarState());
    }
  }
  ///************************************************************
  UserModel? model;
  void getUserData() {
    emit(HomeGetDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {

      model = UserModel.fromJson(value.data()!);
      emit(HomeGetDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeGetDataErrorState());
    });
  }
  ///************************************************************
  void updateUser({
    required String name,
    required String bio,
    required String phone,
    String? cover,
    String? image
  }) {
    UserModel userModel = UserModel(
        name: name,
        phone: phone,
        uId: uId,
        image:image??model!.image,
        cover:cover?? model!.cover,
        email: model!.email ,
        bio: bio,
        isEmailVerified: false);

    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .update(userModel.toMap())
        .then((value) {
      getUserData();
    })
        .catchError((error) {
      emit(HomeUserUpdateErrorState());
    });


  }

/// ************** ProfileImage ***************************/
  var picker = ImagePicker(); // for all

  File? profileImage;
  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);

      emit(HomeProfilePickerSuccessState());
    } else {
      print('No Image Selected');
      emit(HomeProfilePickerErrorState());
    }
  }

  File? coverImage;
  Future getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(HomeCoverPickerSuccessState());
    } else {
      print('No Image Selected');
      emit(HomeCoverPickerErrorState());
    }
  }
/**********************************************************/
  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,}
      ) {

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(profileImage!.path).pathSegments.last}")
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          bio: bio,
          phone: phone,
          name: name,
          image: value
        );
        emit(HomeDownloadImageSuccessState());
      }).catchError((error) {
        emit(HomeDownloadImageErrorState());
      });
      emit(HomeUpdateImageSuccessState());
    }).catchError((error) {
      print("error is ${error.toString()}");
      emit(HomeUpdateImageErrorState());
    });
  }
  /***********************************************************/
  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
}) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(coverImage!.path).pathSegments.last}")
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
            bio: bio,
            phone: phone,
            name: name,
            cover: value
        );
        emit(HomeDownloadCoverSuccessState());
      }).catchError((error) {
        emit(HomeDownloadCoverErrorState());
      });
      emit(HomeUpdateCoverSuccessState());
    }).catchError((error) {});
    emit(HomeUpdateCoverErrorState());
  }
///**************************************************************
  File? postImage;
  Future getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImagePickerSuccessState());
    } else {
      print('No Image Selected');
      emit(PostImagePickerErrorState());
    }
  }
  void createPost({
    required String date,
    required String post,
    String? postImage,

  }) {
    PostModel userModel = PostModel(
        name: model!.name,
        uId: uId,
        image:model!.image,
date: date,
      post: post,
      postImage: postImage??""
       );

    FirebaseFirestore.instance
        .collection('posts')
        .doc(userModel.uId)
        .update(userModel.toMap())
        .then((value) {
      getUserData();
    })
        .catchError((error) {
      emit(HomeUserUpdateErrorState());
    });


  }

  void uploadPostImage({
    required String date,
    required String post,
    }
      ) {

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(postImage!.path).pathSegments.last}")
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
       createNewPost(
           date: date,
           post: post,
           postImage: value);
        emit(CreatePostSuccessState());
      }).catchError((error) {
        emit(CreatePostSuccessState());
      });
      emit(HomeUpdateImageSuccessState());
    }).catchError((error) {
      print("error is ${error.toString()}");
      emit(CreatePostErrorState());
    });
  }


void createNewPost({
  required String date,
  required String post,
  String? postImage,
}){


    PostModel postModel =PostModel(
      image: model!.image,
       name: model!.name,
       uId: model!.uId,
       post: post,
       postImage: postImage??"",
       date: date,

    );
    emit(CreatePostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc('1')
        .set(postModel.toMap())
        .then((value) {
          emit(CreatePostSuccessState());
    })
        .catchError((error){
          emit(CreatePostErrorState());
    });
}


}
