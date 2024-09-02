import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/utils.dart';
import 'package:client/features/home/model/song_model.dart';
import 'package:client/features/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/provider/current_song_notifier.dart';
import '../../../../core/provider/current_user_notifier.dart';

class MusicPlayer extends ConsumerWidget {
  const MusicPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongNotifierProvider);
    final token = ref.watch(currentUserNotifierProvider.select((user) => user!.token));
    final userFavorits = ref.watch(currentUserNotifierProvider.select((value) => value!.favorites));
    final songNotifier = ref.read(currentSongNotifierProvider.notifier);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              hexToColor(currentSong!.hex_code),
              const Color(0xff121212)
            ]),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Scaffold(
        backgroundColor: Pallete.transparentColor,
        appBar: AppBar(
          backgroundColor: Pallete.transparentColor,
          leading: Transform.translate(
            offset: const Offset(-15, 0),
            child: IconButton(
              splashColor: Pallete.transparentColor,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.keyboard_arrow_down),
              color: Pallete.whiteColor,
              iconSize: 40,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Hero(
                  tag: 'music-image',
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(currentSong!.thumbnail_url),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentSong.song_name,
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Pallete.whiteColor),
                          ),
                          Text(
                            currentSong.artist,
                            style: TextStyle(
                                color: Pallete.subtitleText,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Expanded(child: const SizedBox()),
                      IconButton(
                          onPressed: () async {
                            await ref.read(homeViewModelProvider.notifier).favSong(songId: currentSong.id);
                          },
                          icon: Icon(
                            userFavorits.where((element) => element.song_id == currentSong.id).toList().isNotEmpty
                                ? CupertinoIcons.heart_fill :
                            CupertinoIcons.heart,)),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  StreamBuilder(
                      stream: songNotifier.audioPlayer!.positionStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox();
                        }
                        final position = snapshot.data;
                        final duration = songNotifier.audioPlayer?.duration;
                        double sliderValue = 0.0;
                        if (position != null && duration != null) {
                          sliderValue =
                              position.inMilliseconds / duration.inMilliseconds;
                        }
                        return Column(
                          children: [
                            StatefulBuilder(builder: (context, myState) {
                              return SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: Pallete.whiteColor,
                                    inactiveTrackColor:
                                    Pallete.whiteColor.withOpacity(0.117),
                                    thumbColor: Pallete.whiteColor,
                                    trackHeight: 4,
                                    overlayShape: SliderComponentShape.noOverlay,
                                  ),
                                  child: Slider(
                                    value: sliderValue,
                                    min: 0,
                                    max: 1,
                                    onChanged: (value) {
                                      sliderValue = value;
                                      myState;
                                    },
                                    onChangeEnd: songNotifier.seek,
                                  ));
                            },),

                            Row(
                              children: [
                                Text(
                                  "${position?.inMinutes}:${(position?.inSeconds ?? 0) < 10 ? '0${position?.inSeconds}' : '${position?.inSeconds}'}",
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      color: Pallete.subtitleText),
                                ),
                                const Expanded(child: SizedBox()),
                                Text(
                                  "${duration?.inMinutes}:${(duration?.inSeconds ?? 0)< 10 ? '0${duration?.inSeconds}' : '${duration?.inSeconds}'}",
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      color: Pallete.subtitleText),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        );
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.shuffle_rounded),
                        color: Pallete.whiteColor,
                        iconSize: 20,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.skip_previous,
                        ),
                        iconSize: 40,
                        color: Pallete.whiteColor,
                      ),
                      IconButton(
                        onPressed: songNotifier.playPause,
                        icon: Icon(songNotifier.isPlaying
                            ? CupertinoIcons.pause_circle_fill
                            : CupertinoIcons.play_circle_fill),
                        iconSize: 80,
                        color: Pallete.whiteColor,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.skip_next),
                        color: Pallete.whiteColor,
                        iconSize: 40,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.repeat_rounded),
                        color: Pallete.whiteColor,
                        iconSize: 20,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.devices_rounded),
                        color: Pallete.whiteColor,
                        iconSize: 20,
                      ),
                      Expanded(child: SizedBox()),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.format_list_bulleted_rounded),
                        color: Pallete.whiteColor,
                        iconSize: 20,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
