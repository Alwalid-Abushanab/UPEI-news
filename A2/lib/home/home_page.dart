import 'package:a1_fakenews/home/home_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("News App"),
      ),
      body:const HomeView(),
    );
  }

}