import 'package:flutter/material.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';

import 'new_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: PlayAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(seconds: 1),
          builder: (context, child, value) {
            return Container(
              width: 70,
              height: 90,
              color: Colors.blue,
            );
          },
          child: Image.network("https://media.istockphoto.com/id/1339466666/vector/breaking-news.jpg?s=612x612&w=0&k=20&c=miuVhN91dJNC5xonwQrSndDTlFGdGrYz866M422cmBQ="),
          onCompleted: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));},// Your splash screen image
        ),
      ),
    );
  }
}
