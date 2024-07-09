import 'package:flutter/material.dart';
import 'package:news_c10_str/views/detail_view/article_detail_view.dart';
import 'package:news_c10_str/views/home/home.dart';
import 'package:news_c10_str/views/news/news_view.dart';
import 'package:news_c10_str/views/search/search_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        SearchView.routeName: (context) => SearchView(),
        NewsView.routeName: (context) => const NewsView(),
        ArticleDetailView.routeName: (context) => const ArticleDetailView(),
      },
    );
  }
}
