import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/home/home_cubit.dart';
import 'package:socialapp/home/home_states.dart';

import '../../shared/styles/icon-broken.dart';

class CreatePost extends StatelessWidget {
var postController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Create Post",
                style: Theme.of(context).textTheme.headline6,
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  IconBroken.Arrow___Left_3,
                  color: Colors.black,
                ),
              ),
              actions: [TextButton(onPressed: () {


                var now =DateTime.now();
                if(cubit.postImage==null) {
                  cubit.createPost(
                      date: now.toString(),
                      post: postController.text);
                } else {
                  cubit.storePostImage(
                    date:  now.toString(),
                    post: postController.text);
                }
              }, child: const Text("POST"))],
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
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${cubit.model!.name}",
                        style: Theme.of(context).textTheme.subtitle2,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: TextFormField(
                        controller: postController,
                    decoration: const InputDecoration(
                      hintText: "What is in your mind...",
                      border: InputBorder.none
                    ),
                  )),
                   if(cubit.postImage!=null)
                       Stack(
                         alignment: AlignmentDirectional.topEnd,
                         children: [
                           Container(
                             height: 160,
                             width: double.infinity,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.all(
                                     Radius.circular(20)
                                 ),
                                 image: DecorationImage(
                                   image: FileImage(cubit.postImage!) ,

                                 )
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: CircleAvatar(
                                 radius: 20,
                                 child: IconButton(
                                     onPressed: (){
                                       cubit.removePostImage;
                                       print(cubit.postImage);
                                     },
                                     icon:Icon(Icons.close)
                                 )
                             ),
                           )
                         ],
                       ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextButton(
                            onPressed: () {
                              cubit.pickPostImage();
                            },
                            child: Row(
                              children: [
                                const Icon((IconBroken.Image)),
                                const Text("add photo")
                              ],
                            )),
                      ),
                      Expanded(
                        child: TextButton(
                            onPressed: () {},
                            child: const Text("#tags")),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
