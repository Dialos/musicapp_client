import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicapp_client/core/providers/current_song_notifier.dart';
import 'package:musicapp_client/core/theme/color_palette.dart';
import 'package:musicapp_client/core/widgets/utils.dart';

class MusicSlab extends ConsumerWidget {
  const MusicSlab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongNotifierProvider);

    if (currentSong == null) {
      return const SizedBox();
    }
    return Stack(
      children: [
        Container(
          height: 66,
          width: MediaQuery.of(context).size.width - 16,
          decoration: BoxDecoration(
            color: hexToColor(currentSong.hex_code),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.all(9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            currentSong.thumbnail_url,
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentSong.song_name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        currentSong.artist,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Palette.subtitleText,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.heart,
                        color: Palette.whiteColor),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.play_fill,
                        color: Palette.whiteColor),
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 8,
          child: Container(
            height: 2,
            width: 20,
            decoration: BoxDecoration(
              color: Palette.whiteColor,
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 8,
          child: Container(
            height: 2,
            width: MediaQuery.of(context).size.width - 32,
            decoration: BoxDecoration(
              color: Palette.inactiveSeekColor,
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ),
      ],
    );
  }
}
