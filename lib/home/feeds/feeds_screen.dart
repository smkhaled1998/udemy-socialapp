import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/styles/icon-broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 5,
              child: Image(
                fit: BoxFit.cover,
                height: 200,
                width: 400,
                image: NetworkImage(
                    'https://img.freepik.com/free-vector/gradient-mountain-landscape_52683-77407.jpg?w=996&t=st=1670034499~exp=1670035099~hmac=a0bbc91f433e573d4ab754c49c5f6168a368cf1e117f0e0778a433cd1ab574ef'),
              ),
            ),
           ListView.separated(
               shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(),
               itemCount: 3,
               itemBuilder: (context,index)=>buildPost(context),
               separatorBuilder: (context,index)=>Container(width: double.infinity,height: 1,color: Colors.grey[200],),
               )
          ],
        ),
      ),
    );
  }
  Widget buildPost (context){
    return Card(
      elevation: 5,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                    radius: 20,
                    backgroundImage:NetworkImage("https://pbs.twimg.com/profile_images/1499915163431936001/qy1BZYXW_400x400.jpg")),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Khaled Said',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Jan 15 02:00 am',
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
                Spacer(),
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.more_horiz))
              ],
            ),
            Container(
              width: double.infinity,
              height: 2,
              color: Colors.grey[200],
            ),
            SizedBox(
              height: 10,
            ),
            Text("يا إدلب جودي ونادي . يا مقبرة الأعادي , سوريا عز بلادي , صمودي يحيينا "),
            Container(
              width: double.infinity,
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 1),
                    child: Container(child: TextButton(onPressed: (){}, child: Text("#ثورة"))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Container(child: TextButton(onPressed: (){}, child: Text("#عقيدة وجهاد"))),
                  )
                ],
              ),
            ),
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://img.freepik.com/free-vector/man-shows-gesture-great-idea_10045-637.jpg?w=740&t=st=1670284443~exp=1670285043~hmac=ed9239418cc812fcb1c47af58414b327dc196e2a94e0ad4cb410303cfd0f6f9b")),
            ),
            SizedBox(height: 7),
            Row(
              children: [
                IconButton(onPressed: (){}, icon: Icon(IconBroken.Heart)),
                Text("120",style: TextStyle(color: Colors.black),),
                Spacer(),
                IconButton(onPressed: (){}, icon: Icon(IconBroken.Chat)),
                Text("20 comments",style: TextStyle(color: Colors.black),),
              ],
            ),
            Container(
              width: double.infinity,
              height: 2,
              color: Colors.grey[200],
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage("https://pbs.twimg.com/profile_images/1499915163431936001/qy1BZYXW_400x400.jpg")
                ),
                SizedBox(width: 15,),
                TextButton(onPressed: (){}, child: Text("write a comment...",style: Theme.of(context).textTheme.caption),),
                Spacer(),
                InkWell(
                  onTap: (){},
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.heart),
                      SizedBox(width: 5,),
                      Text("like")
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
