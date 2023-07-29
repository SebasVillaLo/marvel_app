import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/utils.dart';

class AppBarCustom extends ConsumerWidget implements PreferredSizeWidget {
  const AppBarCustom({
    this.onPressed,
    required this.icon,
    super.key,
  });

  final void Function()? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context, ref) {
    return AppBar(
      title: const Text(
        'Cómics',
        style: titleAppBar,
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: onPressed,
          icon: icon,
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
