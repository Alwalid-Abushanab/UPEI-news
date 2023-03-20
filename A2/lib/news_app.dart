import 'package:a1_fakenews/routes/route_generator.dart';
import 'package:flutter/material.dart';

class NewsApp extends MaterialApp {

  NewsApp({Key? key}) : super(key: key,
    initialRoute:  RouteGenerator.homePage,
    onGenerateRoute: RouteGenerator.generateRoute,

    theme: ThemeData(
      primarySwatch: Colors.amber,
    ),
  );
}