import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_c10_str/models/article_model.dart';

class NewsItem extends StatelessWidget {
  final Articles article;

  const NewsItem({required this.article, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: CachedNetworkImage(
              imageUrl: article.urlToImage ?? "",
              width: double.infinity,
              fit: BoxFit.fill,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.source?.name ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.w300, color: Colors.grey),
                ),
                Text(
                  article.title ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.black),
                ),
                Text(
                  article.description ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.w300, color: Colors.black),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
