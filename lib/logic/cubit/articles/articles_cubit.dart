import 'package:covid_pandemic/data/models/news.dart';
import 'package:covid_pandemic/data/repositories/news_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

part 'articles_state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  NewsRepository newsRepository = NewsRepository();

  ArticlesCubit() : super(NewsInitial());
  Future<void> getNewsByCategory(String category) async {
    try {
      emit(Loading());
      List<Article> articles = await newsRepository.getNewsByCategory(category);
      emit(ArticlesLoaded(articles: articles));
    } catch (e) {
      emit(Error(message: e.toString()));
    }
  }
}
