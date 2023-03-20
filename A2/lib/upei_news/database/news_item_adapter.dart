import 'package:a1_fakenews/fakeNews/model/model.dart';
import 'package:hive/hive.dart';

class NewsItemAdapter extends TypeAdapter<NewsItem>{
  @override
  NewsItem read(BinaryReader reader) {
    var numOfFields = reader.readByte();

    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++)
        reader.readByte(): reader.read(),
    };

    return NewsItem(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as DateTime,
      fields[4] as String,
      fields[5] as bool,
      fields[6] as bool,
    );
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, NewsItem news) {

    writer
    ..writeByte(7)
      ..writeByte(0)
      ..write(news.title)
      ..writeByte(1)
      ..write(news.body)
      ..writeByte(2)
      ..write(news.author)
      ..writeByte(3)
      ..write(news.date)
      ..writeByte(4)
      ..write(news.image)
      ..writeByte(5)
      ..write(news.isRead)
      ..writeByte(6)
      ..write(news.bookMarked);
  }

}