import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/home/home_cubit.dart';
import 'package:socialapp/home/home_states.dart';


import '../../shared/styles/icon-broken.dart';

class EditProfile extends StatelessWidget {
  var bioController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        nameController.text=cubit.model!.name!;
        bioController.text=cubit.model!.bio!;
        phoneController.text=cubit.model!.phone!;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(IconBroken.Arrow___Left_2, color: Colors.black,),


            ),
            title: const Text(
              'Edit Profile', style: TextStyle(color: Colors.black),),
            actions: [
              TextButton(onPressed: () {
               cubit.updateUser(
                   name: nameController.text,
                   phone: phoneController.text,
                   bio: bioController.text
               );

              }, child: const Text('Update'))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if(HomeCubit.get(context).profileImage !=null ||HomeCubit.get(context).coverImage !=null)
                    Row(
                      children: [
                        if(HomeCubit.get(context).profileImage !=null)
                          Expanded(
                            child: InkWell(
                              onTap: (){
                                HomeCubit.get(context).uploadProfileImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue[400],
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Icon(IconBroken.Profile,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Upload Profile ',
                                          style: TextStyle(color: Colors.white,fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    if(state is SocialUpdateLoadingState)
                                      LinearProgressIndicator(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        SizedBox(
                          width: 8,
                        ),
                        if(HomeCubit.get(context).coverImage !=null)
                          Expanded(
                            child: InkWell(
                              onTap: (){
                                HomeCubit.get(context).uploadCoverImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text
                                );
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          IconBroken.Image,color: Colors.white,size: 24,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Upload Cover',
                                          style: TextStyle(color: Colors.white,fontSize: 20),),
                                      ],
                                    ),
                                    if(state is SocialUpdateLoadingState)
                                      LinearProgressIndicator(),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.blue[400],
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  SizedBox(height: 10,),
                  Container(
                    height: 160,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4),
                                  ),

                                ),
                                child: Image(
                                  image: cubit.coverImage==null
                                      ? NetworkImage("${cubit.model!.cover}")
                                      : FileImage(cubit.coverImage!) as ImageProvider,
                                ),
                              ),
                              CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: IconButton(onPressed: () {
                                    cubit.getCoverImage();
                                  },
                                      icon: const Icon (
                                        IconBroken.Camera, size: 20,)))
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 43,
                              backgroundColor: Theme
                                  .of(context)
                                  .scaffoldBackgroundColor,
                              child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: cubit.profileImage
                                      == null
                                      ? NetworkImage("${cubit.model!.image}")
                                      : FileImage(cubit.profileImage!) as ImageProvider
                              ),
                            ),
                            //The argument type 'File?' can't be assigned to the parameter type 'File'
                            CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.blue,
                                child: IconButton(

                                    onPressed: () {
                                      cubit.getProfileImage();

                                    },
                                    icon: const Icon (
                                      IconBroken.Camera, size: 15,)))
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('name'),
                          prefixIcon: Icon(IconBroken.User)
                      )
                  ),
                  const SizedBox(height: 15,),
                  TextFormField(
                      controller: bioController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('bio'),
                          prefixIcon: Icon(IconBroken.Info_Circle)
                      )
                  ),
                  const SizedBox(height: 15,),
                  TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('phone'),
                          prefixIcon: Icon(IconBroken.Call)
                      )
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
