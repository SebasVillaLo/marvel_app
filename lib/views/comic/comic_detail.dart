import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/models.dart';
import '../../providers/providers.dart';

class ComicDetail extends ConsumerStatefulWidget {
  final ComicModel comic;

  const ComicDetail({super.key, required this.comic});

  @override
  ConsumerState<ComicDetail> createState() => _ComicDetailState();
}

class _ComicDetailState extends ConsumerState<ComicDetail> {
  @override
  void initState() {
    super.initState();

    // Call the 'getComics' method of the 'listCharacterProvider' notifier
    // to fetch the list of characters associated with the given comic ID.
    // The comic ID is obtained from the 'widget.comic.id' property.
    // Note: It's assumed that 'widget.comic.id' is not null, as indicated by the '!' operator.
    ref
        .read(listCharacterProvider.notifier)
        .getComics(widget.comic.id!.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        _CustomSliverAppBar(
          comic: widget.comic,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 1,
            (context, index) => _ComicBody(
              comic: widget.comic,
            ),
          ),
        )
      ],
    ));
  }
}

class _ComicBody extends StatelessWidget {
  final ComicModel comic;
  const _ComicBody({required this.comic});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  '${comic.thumbnail!.path}/portrait_xlarge.${comic.thumbnail!.exten!.name.toLowerCase()}',
                  width: size.width * 0.3,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comic.title!,
                      style: textStyle.titleLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      comic.description!,
                      style: textStyle.bodyMedium,
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        _ActorsByComic(),
      ],
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final ComicModel comic;

  const _CustomSliverAppBar({required this.comic});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          comic.title!,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                '${comic.thumbnail!.path}/portrait_uncanny.${comic.thumbnail!.exten!.name.toLowerCase()}',
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return FadeIn(
                      child: child,
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.7, 1.0],
                    colors: [Colors.transparent, Colors.black87],
                  ),
                ),
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    stops: [0.0, 0.3],
                    colors: [
                      Colors.black87,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ActorsByComic extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final characters = ref.watch(listCharacterProvider);
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: characters.length,
        itemBuilder: (context, index) {
          final character = characters[index];
          return Container(
            padding: const EdgeInsets.all(8),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      '${character.thumbnail!.path!}/portrait_xlarge.${character.thumbnail!.exten!.name.toLowerCase()}',
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                FadeIn(child: Text(character.name!, maxLines: 2)),
                FadeIn(
                  child: Text(
                    character.description!,
                    maxLines: 2,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
