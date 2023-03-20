import 'package:a1_fakenews/upei_news/fetcher/upei_news_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'upei_news_test.mocks.dart';

@GenerateMocks([http.Client])

void main(){
  group("upei sourcer", ()  {
    late UPEINewsSource source;
    late MockClient mockClient;
    const rssFeed = '''
        <?xml version="1.0" encoding="utf-8"?>
        <rss version="2.0" xmlns:media="http://search.yahoo.com/mrss/">
          <channel>
            <title>UPEI News</title>
            <description>News and Announcements from the University of Prince Edward Island</description>
            <link>https://www.upei.ca/</link>
            <item>
              <title>Test news</title>
              <link>https://www.upei.ca/test-news-item</link>
              <description>&lt;p&gt;Test news item description.&lt;/p&gt;</description>
              <pubDate>Mon, 21 Mar 2022 13:00:00 EST</pubDate>
              <dc:creator xmlns:dc="http://purl.org/dc/elements/1.1/">John Doe</dc:creator>
            </item>
          </channel>
        </rss>
        ''';

    setUp(() {
      mockClient = MockClient();
      source = UPEINewsSource(client: mockClient);
    });

    test('returns a list of news items', () async {

      when(mockClient.get(Uri.parse('https://www.upei.ca/feeds/news.rss')))
          .thenAnswer((_) async => http.Response(rssFeed.toString(), 200));

      final newsItems = await source.getNews();

      expect(newsItems.length, 1);
      expect(newsItems[0].title, 'Test news');
      expect(newsItems[0].author, 'John Doe');
      expect(newsItems[0].image, '');
      expect(newsItems[0].bookMarked, false);
      expect(newsItems[0].isRead, false);
    });

    test('returns a list of news items', () async {

      when(mockClient.get(Uri.parse('https://www.upei.ca/feeds/news.rss')))
          .thenAnswer((_) async => http.Response(rssFeed.toString(), 404));

      expect(source.getNews(), throwsException);
    });

    tearDown(() {
      mockClient.close();
    });
  });
}