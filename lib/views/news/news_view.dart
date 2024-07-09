import 'package:flutter/material.dart';
import 'package:news_c10_str/views/news/widgets/news_view_body.dart';
import 'package:news_c10_str/shared/network/remote/api_manager.dart';
import 'package:news_c10_str/widgets/custom_appbar.dart';
import 'package:news_c10_str/widgets/custom_drawer.dart';

class NewsView extends StatefulWidget {
  static const String routeName = 'NewsView';
  final String? categoryId;

  const NewsView({this.categoryId, super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  bool _searchSelected = true;

  void appBarChange() {
    setState(() {
      _searchSelected = !_searchSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: defaultBar(context, _key),
      ),
      drawer: const CustomDrawer(),
      body: FutureBuilder(
        future: ApiManager.getSources(widget.categoryId ?? ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }

          var sourcesList = snapshot.data?.sources ?? [];
          if (sourcesList.isEmpty) {
            return const Center(child: Text("No Sources"));
          }
          return NewsTab(
            sources: sourcesList,
          );
        },
      ),
    );
  }
}
