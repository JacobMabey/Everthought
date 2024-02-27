import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  
  @override
  State<StatefulWidget> createState() => SettingsState();
  
}

class SettingsState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Settings'),
        centerTitle: false,
      ),

      body: const Text('Welcome to Settings!'),

    );
  }
}