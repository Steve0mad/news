part of 'search_news_cubit.dart';

@immutable
sealed class SearchNewsState {}

final class SearchNewsInitial extends SearchNewsState {}

final class SearchNewsLoading extends SearchNewsState {}

final class SearchNewsSuccess extends SearchNewsState {}

final class SearchNewsFailure extends SearchNewsState {
  final String errMsg;
  SearchNewsFailure(this.errMsg);
}
