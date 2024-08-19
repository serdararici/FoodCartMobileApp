import 'package:flutter/material.dart';
import 'package:food_cart_app/colors.dart';

class Likes extends StatefulWidget {
  const Likes({super.key});

  @override
  State<Likes> createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beğeniler',style: TextStyle(color: Colors.white),),
        backgroundColor: mainColor,
      ),
      body: Center(
        child: Text('Beğeniler sayfası içerikleri buraya gelecek.'),
      ),
    );
  }
}
