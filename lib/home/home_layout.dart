import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/home/create-post/create-post.dart';
import 'package:socialapp/home/home_cubit.dart';
import 'package:socialapp/home/home_states.dart';
import 'package:socialapp/shared/components.dart';

import '../shared/styles/icon-broken.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if(state is NewPostState)
          {
            navigateTo(context, CreatePost());
          }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title:
              Text(cubit.titles[cubit.currentIndex], style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),),
              actions: [
                TextButton(onPressed: () {
                  signOut(context);
                },
                    child: const Text(
                      'Sign Out', style: TextStyle(color: Colors.black),))
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(IconBroken.Home), label: 'Feeds'),
                BottomNavigationBarItem(icon: Icon(IconBroken.Chat), label: 'Chats'),
                BottomNavigationBarItem(icon: Icon(IconBroken.Paper_Upload), label: 'Posts'),
                BottomNavigationBarItem(icon: Icon(IconBroken.User), label: 'Users'),
                BottomNavigationBarItem(icon: Icon(IconBroken.Setting), label: 'Settings')
              ],
            )

          // ConditionalBuilder(
          //   condition:cubit.model !=null ,
          //   builder: (ctx){
          //     return Column(
          //       children: [
          //         if(cubit.model!.isEmailVerified==false)
          //         Container(
          //           color: Colors.amber.withOpacity(0.7),
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Row(
          //               children: [
          //                 Icon(Icons.warning_rounded),
          //                 SizedBox(width: 15),
          //                 Text('Please Verify Your Email',style: TextStyle(fontWeight: FontWeight.bold),),
          //                 Spacer(),
          //                 TextButton(onPressed: (){
          //                   cubit.checkMail();
          //                 }, child: Text('Send'))
          //
          //               ],
          //             ),
          //           ),
          //         )
          //       ],
          //     );
          //   },
          //   fallback: (ctx)=>const Center(child: CircularProgressIndicator(),),
          // )
        );
      },

    );
  }
}
