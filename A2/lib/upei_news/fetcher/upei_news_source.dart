import 'package:a1_fakenews/fakeNews/model/news_item.dart';
import 'package:a1_fakenews/fakeNews/model/fetcher/news_gen.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;

class UPEINewsSource extends NewsSourcer {
  static const _feedUrl = 'https://www.upei.ca/feeds/news.rss';
  late http.Client client;

  UPEINewsSource({client}): this.client = client??http.Client();

  @override
  Future<List<NewsItem>> getNews() async {
    var news = <NewsItem> [];
    final response = await client.get(Uri.parse(_feedUrl));
    if (response.statusCode == 200) {
      final feed = RssFeed.parse(response.body);
      for (int i = 0; i < 10; i++) {
        if (i >= feed.items!.length) break;

        RssItem rssItem = feed.items![i];
        //news article title
        final title = rssItem.title ?? "";

        //raw story with some html formatting in it
        final body = rssItem.description ?? "";

        //author
        final author = rssItem.dc?.creator ?? "";

        //date
        final pubDate = rssItem.pubDate ?? DateTime.now();

        //story url (where we can get the picture from)
        String link = rssItem.link ?? "";
        // Extract image URL from story page
        final articleResponse = await http.get(Uri.parse(link));
        if (articleResponse.statusCode == 200) {
          var document = parse(articleResponse.body);
          dom.Element? imageElement = document
              .getElementsByClassName("medialandscape")[0]
              .querySelector('img');
          String imageLink = imageElement != null ? "https://upei.ca/" +
              imageElement.attributes['src']! ?? "" : "";

          news.add(NewsItem(title, body, author, pubDate, imageLink, false,false));
        }
        else {
          news.add(NewsItem(title, body, author, pubDate, "", false, false));
        }
      }
      return news;
    } else {
      throw Exception('Failed to load news feed');
    }
  }
}
