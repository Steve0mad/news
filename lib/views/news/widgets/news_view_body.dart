import 'package:flutter/material.dart';
import 'package:news_c10_str/models/source_reposne.dart';
import 'package:news_c10_str/views/detail_view/article_detail_view.dart';
import 'package:news_c10_str/views/news/widgets/news_item.dart';
import 'package:news_c10_str/views/news/widgets/source_item.dart';
import 'package:news_c10_str/shared/network/remote/api_manager.dart';

class NewsTab extends StatefulWidget {
  final List<Sources> sources;

  const NewsTab({super.key, required this.sources});

  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
            length: widget.sources.length,
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: const EdgeInsets.only(right: 10),
              dividerColor: Colors.transparent,
              isScrollable: true,
              onTap: (value) {
                setState(() {});
                selectedIndex = value;
              },
              indicatorColor: Colors.transparent,
              tabs: widget.sources
                  .map((e) => Tab(
                        child: SourceItem(
                          source: e,
                          isSelected:
                              widget.sources.elementAt(selectedIndex) == e,
                        ),
                      ))
                  .toList(),
            )),
        FutureBuilder(
          future:
              ApiManager.getNewsData(widget.sources[selectedIndex].id ?? ""),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.green,
              ));
            }
            if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong"));
            }

            var articlesList = snapshot.data?.articles ?? [];
            if (articlesList.isEmpty) {
              return const Center(child: Text("No Sources"));
            }
            return Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 12,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.popAndPushNamed(
                        context,
                        ArticleDetailView.routeName,
                        arguments: articlesList[index],
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NewsItem(article: articlesList[index]),
                    ),
                  );
                },
                itemCount: articlesList.length,
              ),
            );
          },
        )
      ],
    );
  }
}
