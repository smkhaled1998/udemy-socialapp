import 'package:flutter/material.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
            Card(
              margin: const EdgeInsets.all(10),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 5,
              child: Container(
                  height: 200,
                  width: 400,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://img.freepik.com/free-vector/gradient-mountain-landscape_52683-77407.jpg?w=996&t=st=1670034499~exp=1670035099~hmac=a0bbc91f433e573d4ab754c49c5f6168a368cf1e117f0e0778a433cd1ab574ef'),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
