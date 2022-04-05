import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:date_format/date_format.dart';
import 'package:covid_pandemic/data/models/news.dart';
import 'package:covid_pandemic/logic/cubit/articles/articles_cubit.dart';
import 'package:covid_pandemic/presentation/screens/web_view_screen.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({Key? key}) : super(key: key);

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late Image image1;
  late Image image2;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: BlocBuilder<ArticlesCubit, ArticlesState>(
          builder: (BuildContext context, state) {
            if (state is ArticlesLoaded) {
              return ListView.separated(
                  itemBuilder: (ctx, index) => newsItem(
                      article: state.articles[index], context: context),
                  itemCount: state.articles.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                        height: 5,
                      ));
            } else if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is Error) {
              return Center(
                child: Text(
                  "Error",
                  style: TextStyle(color: Theme.of(context).errorColor),
                ),
              );
            }
            return const Text('Something went wrong');
          },
        ),
      ),
    );
  }

  Widget newsItem({required Article article, required BuildContext context}) =>
      InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => WebViewScreen(
                article: article,
              ),
            ),
          );
        },
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                article.urlToImage.isNotEmpty
                    ? FadeInImage.assetNetwork(
                        placeholder: 'assets/images/loading.gif',
                        image: article.urlToImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 250,
                        imageErrorBuilder: (BuildContext context, Object ob,
                            StackTrace? stakeTrace) {
                          return Image.asset('assets/images/error.gif');
                        },
                      )
                    : Image.asset('assets/images/error.gif'),
                Text(
                  article.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                ),
                const Divider(
                  thickness: 5,
                  color: Colors.blueAccent,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      article.source.name,
                      textAlign: TextAlign.start,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      formatDate(article.publishedAt, [yyyy, '-', mm, '-', dd]),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
