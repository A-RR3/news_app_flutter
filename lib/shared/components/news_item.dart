import 'package:flutter/material.dart';
import 'package:news_app_bloc/core/utils/extensions.dart';
import 'package:news_app_bloc/domain/models/news_model.dart';

class NewsItem extends StatelessWidget {
  NewsModel article;

  NewsItem({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.deviceSize.width * .15,
      child: Card(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 3,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 4,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                child: SizedBox.square(
                    dimension: context.deviceSize.width * 0.28,
                    child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(article.urlToImage.isNotEmpty
                            ? article.urlToImage
                            : 'https://i.imgur.com/kKc9A5p.jpeg'))),
              ),
            ),
            Flexible(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: context.deviceSize.width * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        article.title,
                        style: context.textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: context.deviceSize.width * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: Text(article.publishedAt,
                          style: context.textTheme.bodySmall),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
