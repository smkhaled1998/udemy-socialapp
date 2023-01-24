import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/home/home_cubit.dart';
import 'package:socialapp/home/home_states.dart';

import '../../shared/styles/icon-broken.dart';

class CreatePost extends StatelessWidget {
var textController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Add Post",
                style: TextStyle(color: Colors.black),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  IconBroken.Arrow___Left_3,
                  color: Colors.black,
                ),
              ),
              actions: [TextButton(onPressed: () {
                var now =DateTime.now();
                if(cubit.postImage==null) {
                  cubit.createNewPost(
                      date: now.toString(),
                      post: textController.text);
                } else {
                  cubit.uploadPostImage(
                    date:  now.toString(),
                    post: textController.text);
                }
              }, child: Text("POST"))],
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage("${cubit.model!.image}"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${cubit.model!.name}",
                        style: Theme.of(context).textTheme.subtitle2,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: TextFormField(
                        controller: textController,
                    decoration: InputDecoration(
                      hintText: "What is in your mind...",
                      border: InputBorder.none
                    ),
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon((IconBroken.Image)),
                              Text("add photo")
                            ],
                          )),
                      Spacer(),
                      TextButton(
                          onPressed: () {},
                          child: Row(
                            children: [Text("#tags")],
                          )),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
