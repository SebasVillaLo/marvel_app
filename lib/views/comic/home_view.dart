import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
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

    // Add a listener to the scroll controller to detect the scroll offset.
    // If the offset is greater than or equal to 100, show the button.
    // Otherwise, hide the button.
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

    // Call the 'getComics' method of the 'listComicProvider' notifier
    // to fetch the list of comics when the widget is initialized.
    ref.read(listComicProvider.notifier).getComics();
  }

  @override
  void dispose() {
    // Dispose of the scroll controller to avoid memory leaks.
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final comics = ref.watch(listComicProvider);
    final comicsNotifier = ref.watch(listComicProvider.notifier);
    final searchProvider = ref.watch(searchedComicsProvider.notifier);
    final colors = Theme.of(context).colorScheme;
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarCustom(
        icon: Icon(
          comicsNotifier.isLoading ? null : Icons.search,
          color: Colors.black,
        ),
        onPressed: () {
          showSearch(
            context: context,
            delegate: SearchComicDelegate(
                searchComicByQuery: searchProvider.searchComicByQuery),
          );
        },
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
