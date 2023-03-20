import 'package:a1_fakenews/fakeNews/cubit/news_cubit.dart';
import 'package:a1_fakenews/fakeNews/display_news/news_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/fakeNews/model/fetcher/fake_news_gen.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("FakeNews"),
        ),
        body:
          MultiBlocProvider(
            providers: [
              BlocProvider<NewsCubit>(
                create: (context) => NewsCubit(FakeNewsGenerator()),
              )
            ],
            child: NewsView(),
      )
    );
  }
}