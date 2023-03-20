// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:a1_fakenews/fakeNews/model/news_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:a1_fakenews/main.dart';

void main() {
  group("NewsItem", () {
    String title = "CS3130";
    String author = "Alwalid";
    String body = "Assignment 1";
    String image = "https://picsum.photos/seed/319/300/200";
    DateTime date = DateTime(2023,2,12);
    bool read = false;
    bool marked = false;

    late NewsItem item;
    late NewsItem item2;
    late NewsItem item3;

    setUp(() {
      item = NewsItem(title, body, author, date, image, read,marked);
      item2 = item.readVersion();
      item3 = NewsItem(title, body, author, date, image, read,marked);
    });

    test("test info", () {
      expect(item.title, title);
      expect(item.author, author);
      expect(item.body, body);
      expect(item.image, image);
      expect(item.date, date);
      expect(item.isRead, read);
    });


    test("Change isRead to true", () {
      expect(item2.isRead, true);
    });

    test("equal and hash code is the same", () {
      expect(item.hashCode, item3.hashCode);
      expect(item, item3);
    });

    test("not equal and not the same hash code", () {
      expect(item.hashCode, isNot(item2.hashCode));
      expect(item, isNot(item2));
    });

  });
}
