import 'package:flutter/material.dart';
import 'package:food_cart_app/colors.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil',style: TextStyle(color: Colors.white),),
        backgroundColor: mainColor,
      ),
      body: Center(
        child: Text('Profil '),
      ),
    );
  }
}
