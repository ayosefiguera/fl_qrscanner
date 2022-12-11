import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/providers/scan_list_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
    BuildContext context, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('History'),
      actions: [
        IconButton(
          icon: const Icon(Icons.delete_forever),
          onPressed: () {
            Provider.of<ScanListProvider>(context, listen: false)
                .deleteAllScans();
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
