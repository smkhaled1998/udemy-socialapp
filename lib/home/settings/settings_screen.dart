import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/home/home_cubit.dart';
import 'package:socialapp/home/home_states.dart';
import 'package:socialapp/home/settings/edit-profile.dart';
import 'package:socialapp/shared/components.dart';

import '../../shared/styles/icon-broken.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
         var  cubit =HomeCubit.get(context);
      return  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 160,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(4),
                                topLeft: Radius.circular(4))),
                        child:  Image(
                          image: NetworkImage("${cubit.model!.cover}"
                              ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      radius: 43,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage("${cubit.model!.image}"),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text("${cubit.model!.name}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "${cubit.model!.bio}",
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          '100',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Posts",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          '90',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Followers",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          '110',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Following",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          '96',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "favorites",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            'Edit Profile',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        )),
                  ),
                  SizedBox(width: 5,),
                  Expanded(
                    flex: 1,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            navigateTo(context, EditProfile());
                          },
                          child: Icon(IconBroken.Edit)
                        )),
                  ),
                ],
              ),
            ],
          ),
        );
      },

    );
  }
}
