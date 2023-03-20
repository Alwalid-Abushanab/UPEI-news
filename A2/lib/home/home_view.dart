import 'package:flutter/material.dart';
import 'package:a1_fakenews/routes/route_generator.dart';

/// Show the high score
class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            ElevatedButton(
                child: const Text('Fake News'),
                onPressed: () => Navigator.pushNamed(context, RouteGenerator.fakeNews)
            ),
            ElevatedButton(
                child: const Text('UPEI News'),
                onPressed: () => Navigator.pushNamed(context, RouteGenerator.upeiNews)
            ),
            ElevatedButton(
                child: const Text('Offline News'),
                onPressed: () => Navigator.pushNamed(context, RouteGenerator.offline)
            ),
          ],
        ),
      ),
    );
  }
}
