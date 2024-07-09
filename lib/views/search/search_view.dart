import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_c10_str/views/detail_view/article_detail_view.dart';
import 'package:news_c10_str/views/search/manger/search_cubit/search_news_cubit.dart';
import 'package:news_c10_str/views/search/widgets/search_item.dart';

class SearchView extends StatelessWidget {
  static const String routeName = 'SearchView';
  SearchView({super.key});
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchNewsCubit>(
      create: (context) => SearchNewsCubit(),
      child: Scaffold(
        body: BlocBuilder<SearchNewsCubit, SearchNewsState>(
          builder: (context, state) {
            if (state is SearchNewsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is SearchNewsFailure) {
              return Center(
                child: Text(state.errMsg),
              );
            }

            var articles = BlocProvider.of<SearchNewsCubit>(context).articles;

            return Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                        25,
                      ),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.green,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          BlocProvider.of<SearchNewsCubit>(context)
                              .searchNews(controller.text);
                        },
                        icon: const Icon(
                          Icons.search,
                          color: Colors.green,
                        ),
                      ),
                      hintText: 'Search Article',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.popAndPushNamed(
                              context,
                              ArticleDetailView.routeName,
                              arguments: articles[index],
                            );
                          },
                          child: SearchItem(
                            article: articles[index],
                          ),
                        );
                      }),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
