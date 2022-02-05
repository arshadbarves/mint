import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTap;
  const AppBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onItemTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: Theme.of(context).cardColor,
        currentIndex: currentIndex,
        selectedLabelStyle: const TextStyle(
            fontFamily: 'Product Sans',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2),
        unselectedLabelStyle: const TextStyle(
            fontFamily: 'Product Sans',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2),
        iconSize: 22,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        elevation: 8,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Theme.of(context).colorScheme.primary,
        type: BottomNavigationBarType.shifting,
        onTap: (int index) => onItemTap(index),
        items: [
          BottomNavigationBarItem(
              icon: const Icon(EvaIcons.homeOutline),
              activeIcon: const Icon(EvaIcons.home),
              label: AppLocalizations.of(
                context,
              )!
                  .labelHome),
          const BottomNavigationBarItem(
              icon: Icon(EvaIcons.bookOpenOutline),
              activeIcon: Icon(EvaIcons.bookOpen),
              label: "Channels"),
          BottomNavigationBarItem(
              icon: const Icon(EvaIcons.downloadOutline),
              activeIcon: const Icon(EvaIcons.download),
              label: AppLocalizations.of(
                context,
              )!
                  .labelDownloads),
          BottomNavigationBarItem(
              icon: const Icon(EvaIcons.musicOutline),
              activeIcon: const Icon(EvaIcons.music),
              label: AppLocalizations.of(
                context,
              )!
                  .labelMusic),
          BottomNavigationBarItem(
              icon: const Icon(EvaIcons.folderOutline),
              activeIcon: const Icon(EvaIcons.folder),
              label: AppLocalizations.of(
                context,
              )!
                  .labelLibrary)
        ]);
  }
}
