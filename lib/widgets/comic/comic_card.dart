import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';

class ComicCard extends StatelessWidget {
  const ComicCard({super.key, required this.comic, required this.image});
  final ComicModel comic;
  final String image;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return const CircularProgressIndicator(
                        strokeWidth: 2,
                      );
                    }
                    return FadeIn(child: child);
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comic.title!,
                    maxLines: 2,
                    style: textStyle.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    comic.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle.bodySmall,
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
