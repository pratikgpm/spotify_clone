import 'package:client/core/provider/current_song_notifier.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/utils.dart';
import 'package:client/features/home/view/widgets/music_player.dart';
import 'package:client/features/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/provider/current_user_notifier.dart';

class MusicSlab extends ConsumerWidget {
  const MusicSlab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongNotifierProvider);
    final userFavorites = ref.watch(currentUserNotifierProvider.select((value) => value!.favorites));
    final songNotifier = ref.read(currentSongNotifierProvider.notifier);
    if (currentSong == null) {
      return const SizedBox();
    }
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MusicPlayer(),));
        // Navigator.of(context).push(
        //     PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
        //       return const MusicPlayer();
        //     },
        //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
        //       final tween = Tween(begin: const Offset(0,1),end: Offset.zero).chain(CurveTween(curve: Curves.easeIn));
        //       final offsetAnimation = animation.drive(tween);
        //       return SlideTransition(position: offsetAnimation,
        //         child: child,);
        //     },
        //     )
        // );
      },
      child: Hero(
        tag: 'music-image',
        child: Stack(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: 66,
              padding: const EdgeInsets.all(9.0),
              width: MediaQuery.of(context).size.width - 16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: hexToColor(currentSong.hex_code),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(currentSong.thumbnail_url),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      SizedBox(
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
                                color: Pallete.whiteColor),
                          ),
                          Text(
                            currentSong.artist,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Pallete.subtitleText,
                                fontSize: 14),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () async {
                            await ref.read(homeViewModelProvider.notifier).favSong(songId: currentSong.id);
                          },
                          icon: Icon(
                             userFavorites.where((fav) => fav.song_id == currentSong.id).toList().isNotEmpty
                             ? CupertinoIcons.heart_fill :
                            CupertinoIcons.heart,
                            color: Pallete.whiteColor,
                          )),
                      IconButton(
                          onPressed: songNotifier.playPause,
                          icon: Icon(
                            songNotifier.isPlaying
                                ? CupertinoIcons.pause_solid
                                : CupertinoIcons.play_arrow_solid,
                            color: Pallete.whiteColor,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: songNotifier.audioPlayer?.positionStream,
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const SizedBox();
                }
                final position = snapshot.data;
                final duration = songNotifier.audioPlayer?.duration;
                double sliderValue = 0.0;
                if(position != null && duration != null){
                  sliderValue = position.inMilliseconds / duration.inMilliseconds;
                }
                return Positioned(
                  bottom: 0,
                  left: 8,
                  child: Container(
                    height: 2,
                    width: sliderValue * (MediaQuery.of(context).size.width-32),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Pallete.whiteColor,
                    ),
                  ),
                );
              }
            ),
            Positioned(
              bottom: 0,
              left: 8,
              child: Container(
                height: 2,
                width: MediaQuery.of(context).size.width - 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Pallete.inactiveSeekColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
