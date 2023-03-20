import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../fakeNews/model/news_item.dart';
import '../../routes/route_generator.dart';
import '../database/cubit/offline_news_cubit.dart';

class OfflineNewsView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Offline News"),
      ),
      body: BlocBuilder<OfflineNewsCubit, OfflineNewsState>(
        builder: (context, state) {
          if(state.item.isEmpty){
            return const Center(child:Text("No Offline News"));
          }
          return ListView.builder(
            itemCount: state.item.length,
            itemBuilder: (BuildContext context, int index) {
              return Material(
                child: InkWell(
                    splashColor: Colors.cyan, //colour when clicked

                    onTap: (){ //update the current page, then go to the content of the clicked news article
                      state.item[index] = state.item[index].readVersion();
                      context.read<OfflineNewsCubit>().update(state.item);
                      Navigator.pushNamed(context, RouteGenerator.articlePage, arguments: state.item[index]);
                    },
                    child: Row(
                      children: [
                        Ink.image(image: NetworkImage(state.item[index].image),
                          width: 150,
                          height: 150,
                        ),
                        const SizedBox(width: 10,),
                        Flexible( child: Text(state.item[index].title, textScaleFactor: 1.5,)),
                        IconButton(
                          color: state.item[index].bookMarked ? Colors.red: Colors.grey.shade700,
                          onPressed: () {
                            context.read<OfflineNewsCubit>().delete(state.item[index]);
                          },
                          icon: const Icon(Icons.bookmark),
                        ),
                      ],
                    )
                ),
                color: getColour(index, state.item[index]), //background colour
              );
            },
          );
      },
    ),
    );
  }
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

/**
    ListView.builder(
    itemCount: state.length,
    itemBuilder: (BuildContext context, int index) {
    final newsItem = state[index];

    return NewsItemWidget(newsItem);
    },
    );
 */