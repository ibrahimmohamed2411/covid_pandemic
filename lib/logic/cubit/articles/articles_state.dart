part of 'articles_cubit.dart';

@immutable
abstract class ArticlesState {}

class NewsInitial extends ArticlesState {}

class Loading extends ArticlesState {}

class ArticlesLoaded extends ArticlesState {
  final List<Article> articles;
  ArticlesLoaded({required this.articles});
}

class Error extends ArticlesState {
  final String? message;
  Error({this.message});
}
