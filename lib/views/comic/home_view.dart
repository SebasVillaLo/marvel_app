import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/comic_model.dart';
import '../../providers/providers.dart';
import '../../utils/utils.dart';
import '../../widgets/shared/loading_full_screen.dart';
import '../views.dart';

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
    ref.read(listComicProvider.notifier).getComics();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final comics = ref.watch(listComicProvider);
    final comicsNotifier = ref.watch(listComicProvider.notifier);
    final colors = Theme.of(context).colorScheme;
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cómics',
          style: titleAppBar,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              await ref.read(listComicProvider.notifier).onRefresh();
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: comics.length,
              itemBuilder: (context, index) {
                final comic = comics[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: FadeInUp(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return ComicDetail(
                            comic: comic,
                          );
                        }));
                      },
                      child: _Card(
                        comic: comic,
                        image:
                            '${comic.thumbnail!.path!}/portrait_xlarge.${comic.thumbnail!.exten!.name.toLowerCase()}',
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            top: comicsNotifier.isLoading ? 0 : size.height,
            bottom: comicsNotifier.isLoading ? 0 : -size.height,
            child: Container(
              height: size.height,
              width: size.width,
              color: colors.background,
              child: const LoadingFullScreen(),
            ),
          ),
        ],
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
