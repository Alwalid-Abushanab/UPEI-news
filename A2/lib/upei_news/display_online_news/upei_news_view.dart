import 'package:a1_fakenews/routes/route_generator.dart';
import 'package:a1_fakenews/upei_news/database/cubit/offline_news_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../fakeNews/model/news_item.dart';
import 'cubit/upei_news_cubit.dart';

class UpeiNewsView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpeiNewsCubit, UpeiNewsState>(
        builder: (context, state) {
          if(state is NewsInitial){ //fetch the news
            context.read<UpeiNewsCubit>().getNews();

            return const Center(
              child: CircularProgressIndicator(strokeWidth: 10),
            );
          }
          else if(state is NewsLoading){//load the news
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 10),
            );
          }
          else if(state is NewsLoaded || state is NewsViewed){ //display the news
            var qNews;

            if(state is NewsLoaded){
              qNews = state as NewsLoaded;
            }
            else
            {
              qNews = state as NewsViewed;
            }
            var news = qNews.news;

            return ListView.builder(
              //build 10 news Articles
              itemCount: 10,
              itemBuilder: (_, i){
                return Material(
                  child: InkWell(
                      splashColor: Colors.cyan, //colour when clicked

                      onTap: (){ //update the current page, then go to the content of the clicked news article
                        news[i] = news[i].readVersion();
                        context.read<UpeiNewsCubit>().update(news);
                        Navigator.pushNamed(context, RouteGenerator.articlePage, arguments: news[i]);
                      },
                      child: Row(
                        children: [
                          Ink.image(image: NetworkImage(news[i].image),
                          width: 150,
                          height: 150,
                          ),
                          const SizedBox(width: 10,),
                          Flexible( child: Text(news[i].title, textScaleFactor: 1.5,)),
                          IconButton(
                            color: news[i].bookMarked ? Colors.red: Colors.grey.shade700,
                            onPressed: () {
                              news[i] = news[i].markedVersion();
                              context.read<UpeiNewsCubit>().update(news);

                              if(news[i].bookMarked){
                                context.read<OfflineNewsCubit>().newsList(news[i]);
                              }
                              else{
                                context.read<OfflineNewsCubit>().delete(news[i]);
                              }
                            },
                            icon: const Icon(Icons.bookmark),
                          ),
                        ],
                      )
                  ),
                  color: getColour(i, news[i]), //background colour
                );
              },
            );
          }
          else{
            if (kDebugMode) {
              print("Error");
            }
            return Column( children: const <Widget>[ Text("An Error occurred", textScaleFactor: 3,)],);
          }
        }
    );
  }

  /// assign a back ground colour based on the position of the item and whether it was read or not
  Color getColour(int i,NewsItem item){
    if(item.isRead){
      return CupertinoColors.inactiveGray;
    }
    else if(i % 2 ==0){
      return Colors.orange;
    }
    else{
      return Colors.orangeAccent;
    }
  }
}