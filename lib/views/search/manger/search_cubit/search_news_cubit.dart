import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_c10_str/models/article_model.dart';

import 'package:news_c10_str/shared/components/constants.dart';
import 'package:news_c10_str/views/search/manger/models/search_model.dart';
import 'package:http/http.dart' as http;

part 'search_news_state.dart';

class SearchNewsCubit extends Cubit<SearchNewsState> {
  List<Articles> articles = [];
  SearchNewsCubit() : super(SearchNewsInitial());

  Future<void> searchNews(String q) async {
    emit(SearchNewsLoading());
    try {
      Uri url = Uri.https(Constants.BASE_URL, "/v2/everything", {
        "apiKey": "050460483215412993fe3f8dcebc160c",
        "q": q,
      });

      var resposne = await http.get(url);

      var json = jsonDecode(resposne.body);
      SearchResponse searchResponse = SearchResponse.fromJson(json);

      articles = searchResponse.articles ?? [];
      emit(SearchNewsSuccess());
    } catch (e) {
      emit(SearchNewsFailure(e.toString()));
    }
  }
}
