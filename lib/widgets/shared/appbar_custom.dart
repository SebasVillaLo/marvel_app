import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({
    this.onPressed,
    required this.icon,
    super.key,
  });

  final void Function()? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Comics',
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
