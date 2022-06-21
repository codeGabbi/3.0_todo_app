
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

   static const String route = 'home-screen';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            children: const [
              Text('this is todo'),
            ],
          ),
        ),
    );
  }
}