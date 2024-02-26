import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  
  @override
  State<StatefulWidget> createState() => ProfileState();
  
}

class ProfileState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    
    return const Scaffold(
      body: Text('Welcome to Profile!'),


    );
  }
}