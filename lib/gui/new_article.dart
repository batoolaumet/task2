import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/article.dart';

class NewsArticleItem extends StatelessWidget {
  final NewsArticle newsArticle;

  NewsArticleItem(this.newsArticle);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(newsArticle.webTitle),
      subtitle: Text(newsArticle.fields["description"]),
      onTap: () async {
        await launchNewsArticleUrl(context, newsArticle.webUrl);
      },
    );
  }

  Future<void> launchNewsArticleUrl(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not open the article.'),
        ),
      );
    }
  }
}
