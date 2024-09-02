import 'package:client/core/provider/current_song_notifier.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/features/home/view/pages/upload_song_page.dart';
import 'package:client/features/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getFavSongProvider).when(
          data: (data) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView.builder(
                itemCount: data.length +1 ,
                itemBuilder: (context, index) {
                  if(index == data.length){
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UploadSongPage(),));
                      },
                      leading: CircleAvatar(
                        radius: 35,
                        backgroundColor: Pallete.backgroundColor,
                        child: Icon(CupertinoIcons.plus,color: Pallete.whiteColor,),
                      ),
                      title: Text("upload new Song",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),),
                    );
                  }
                  final song = data[index];
                  return ListTile(
                  onTap: () {
                    ref.read(currentSongNotifierProvider.notifier).updateSong(song);
                  },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(song.thumbnail_url),
                      radius: 35,
                      backgroundColor: Pallete.backgroundColor,
                    ),
                    title: Text(
                      song.song_name,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(song.artist,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),),
                  );
                },
              ),
            );
          },
          error: (error, st) {
            return Center(child: Text(error.toString()));
          },
          loading: () => const Loader(),
        );
  }
}
