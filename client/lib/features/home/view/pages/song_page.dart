import 'package:client/core/provider/current_song_notifier.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/utils.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/features/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/search_field.dart';

class SongPage extends ConsumerWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentlyPlayedSong =
        ref.watch(homeViewModelProvider.notifier).getRecentlyPlayedSongs();
    final currentSong = ref.watch(currentSongNotifierProvider);
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 500 ),
        decoration: currentSong == null ? null :  BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              hexToColor(currentSong.hex_code),
              Pallete.transparentColor
            ],
            stops:  const[0.0,0.3]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  CircularNameIcon("P"),
                  SizedBox(width: 10,),
                  topicContainer("All", true),
                  topicContainer("Music"),
                  topicContainer("Podcast"),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 36.0),
              child: SizedBox(
                height: 280,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: recentlyPlayedSong.length,
                  itemBuilder: (context, index) {
                    final song = recentlyPlayedSong[index];
                    return GestureDetector(
                      onTap: () {
                        ref.read(currentSongNotifierProvider.notifier).updateSong(song);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff212121),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: const EdgeInsets.only(right: 20),
                        child: Row(
                          children: [
                            Container(
                              width: 56 ,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(song.thumbnail_url),
                                      fit: BoxFit.cover),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      bottomLeft: Radius.circular(4))),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Flexible(
                                child: Text(
                              song.song_name,
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w700),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            )),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Latest Today',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
              ),
            ),
            ref.watch(getAllSongProvider).when(
                data: (songs) {
                  return SizedBox(
                    height: 280,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: songs.length,
                      itemBuilder: (context, index) {
                        final song = songs[index];
                        return GestureDetector(
                          onTap: () {
                            ref
                                .read(currentSongNotifierProvider.notifier)
                                .updateSong(song);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 160,
                                  height: 160,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            song.thumbnail_url,
                                          ),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                    width: 160,
                                    child: Text(
                                      maxLines: 1,
                                      song.song_name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          overflow: TextOverflow.ellipsis),
                                    )),
                                SizedBox(
                                    width: 160,
                                    child: Text(
                                      song.artist,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Pallete.subtitleText,
                                          fontWeight: FontWeight.w500),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                error: (error, st) {
                  return Center(child: Text(error.toString()));
                },
                loading: () => const Loader()),
          ],
        ),
      ),
    );
  }
}
