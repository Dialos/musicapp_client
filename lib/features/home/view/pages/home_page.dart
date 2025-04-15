import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicapp_client/core/providers/current_user_notifier.dart';
import 'package:musicapp_client/core/theme/color_palette.dart';
import 'package:musicapp_client/features/home/view/pages/library_page.dart';
import 'package:musicapp_client/features/home/view/pages/songs_page.dart';
import 'package:musicapp_client/features/home/view/widgets/music_slab.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int selectedIndex = 0;

  final pages = [
    SongsPage(),
    LibraryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    //   final user = ref.watch(currentUserNotifierProvider);

    return Scaffold(
      body: Stack(
        children: [
          pages[selectedIndex],
          const Positioned(
            bottom: 0,
            child: MusicSlab(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                selectedIndex == 0
                    ? 'assets/images/home_filled.png'
                    : 'assets/images/home_unfilled.png',
                color: selectedIndex == 0
                    ? Palette.whiteColor
                    : Palette.inactiveBottomBarItemColor,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/library.png',
                color: selectedIndex == 1
                    ? Palette.whiteColor
                    : Palette.inactiveBottomBarItemColor,
              ),
              label: 'Library',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                selectedIndex == 2
                    ? 'assets/images/search_filled.png'
                    : 'assets/images/search_unfilled.png',
                color: selectedIndex == 2
                    ? Palette.whiteColor
                    : Palette.inactiveBottomBarItemColor,
              ),
              label: 'Search',
            ),
          ]),
    );
  }
}
