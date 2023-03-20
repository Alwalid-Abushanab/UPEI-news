import 'package:a1_fakenews/news_observer.dart';
import 'package:a1_fakenews/upei_news/database/cubit/offline_news_cubit.dart';
import 'package:a1_fakenews/upei_news/database/news_database.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'news_app.dart';

void main() async {
  await NewsDataBase.init();

  BlocOverrides.runZoned(
        () => runApp( MultiBlocProvider(
          providers: <BlocProvider>[
            BlocProvider<OfflineNewsCubit>(
              create: (_)=> OfflineNewsCubit(NewsDataBase()),
            ),
          ],
          child: NewsApp(),
        )),
    blocObserver: NewsObserver(),
  );
}

