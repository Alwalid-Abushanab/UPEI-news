import 'package:a1_fakenews/upei_news/display_online_news/upei_news_view.dart';
import 'package:a1_fakenews/upei_news/fetcher/upei_news_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/upei_news_cubit.dart';

class UpeiNewsPage extends StatelessWidget {
  const UpeiNewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("UPEI News"),
        ),
        body:
        MultiBlocProvider(
          providers: [
            BlocProvider<UpeiNewsCubit>(
              create: (context) => UpeiNewsCubit(UPEINewsSource()),
            )
          ],
          child: UpeiNewsView(),
        )
    );
  }
}