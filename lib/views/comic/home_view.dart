import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/comic_model.dart';
import '../../utils/utils.dart';
import '../../viewmodels/viewmodels.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  final ScrollController _scrollController = ScrollController();
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset >= 100) {
        setState(() {
          _showButton = true;
        });
      } else {
        setState(() {
          _showButton = false;
        });
      }
    });
    ref.read(listComicViewModelProvider.notifier).getComics();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final comics = ref.watch(listComicViewModelProvider);
    final colors = Theme.of(context).colorScheme;
    final Size size = MediaQuery.of(context).size;

    if (comics.isEmpty) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 4,
            backgroundColor: colors.primaryContainer,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cómics',
          style: titleAppBar,
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: comics.length,
        itemBuilder: (context, index) {
          final comic = comics[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: FadeIn(
              child: _Card(
                  comic: comic,
                  image:
                      '${comics[index].thumbnail!.path!}/portrait_xlarge.${comics[index].thumbnail!.exten!.name.toLowerCase()}'),
            ),
          );
        },
      ),
      floatingActionButton: _showButton
          ? FloatingActionButton(
              onPressed: () {
                _scrollController.animateTo(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              },
              child: const Icon(Icons.arrow_upward))
          : null,
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.comic, required this.image});
  final ComicsModel comic;
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
                child: Image.network(image,
                    loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const CircularProgressIndicator(
                      strokeWidth: 2,
                    );
                  }
                  return FadeIn(child: child);
                }),
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
