import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '../delegate/search_delegate.dart';
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
      appBar: const AppBarCustom(),
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
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return ComicDetail(
                        comic: comic,
                      );
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: FadeInUp(
                      child: ComicCard(
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

class AppBarCustom extends ConsumerWidget implements PreferredSizeWidget {
  const AppBarCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final searchProvider = ref.watch(searchedComicsProvider.notifier);
    return AppBar(
      title: const Text(
        'Cómics',
        style: titleAppBar,
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            showSearch(
              context: context,
              delegate: SearchComicDelegate(
                  searchComicByQuery: searchProvider.searchComicByQuery),
            );
          },
          icon: const Icon(Icons.search, color: Colors.black),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
