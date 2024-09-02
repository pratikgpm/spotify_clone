import 'dart:convert';
import 'dart:io';
import 'package:client/core/constants/server_constant.dart';
import 'package:client/core/failure/failure.dart';
import 'package:client/features/home/model/song_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref){
  return HomeRepository();
}

class HomeRepository
{
  Future<Either<AppFailure, String>> uploadSong(
      {
        required File selectedAudio,
        required File selectedThumbnail,
        required String songName,
        required String artist,
        required String hexCode,
        required String token,

      }) async
  {
    try{
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${ServerConstant.serverURl}/song/upload'),
      );
      request
        ..files.addAll([
          await http.MultipartFile.fromPath('song', selectedAudio.path),
          await http.MultipartFile.fromPath('thumbnail', selectedThumbnail.path),
        ])
        ..fields.addAll(
          {'artist': artist, 'song_name': songName, 'hex_code': hexCode},
        )
        ..headers.addAll(
          {
            'x-auth-token':token,
          },
        );

      final res = await request.send();
      if(res.statusCode != 201){
        return Left(AppFailure(await res.stream.bytesToString()));
      }
      return Right(await res.stream.bytesToString());
    }
    catch(e){
     return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure,List<SongModel>>> getAllSongs({required String token})
  async{
    try{
      final res = await http.get(Uri.parse('${ServerConstant.serverURl}/song/list'),
      headers: {
        'content-Type':'application/json',
        'x-auth-token':token,
      }
      );
      var resBodyMap = jsonDecode(res.body);
      if(res.statusCode != 200)
      {
          resBodyMap= resBodyMap as Map<String ,dynamic>;
          return Left(AppFailure(resBodyMap['detail']));
      }
      List<SongModel> songs = [];
      resBodyMap = resBodyMap as List;
      for(final map in resBodyMap){
        songs.add(SongModel.fromMap(map));
      }
      return Right(songs);
    }
        catch(e){
      return Left(AppFailure(e.toString()));
        }
  }

  Future<Either<AppFailure,bool >> favSongs({required String token,required String songID})
  async{
    try{
      final res = await http.post(Uri.parse('${ServerConstant.serverURl}/song/favorite'),
          headers: {
            'content-Type':'application/json',
            'x-auth-token':token,
          },
          body: jsonEncode({
            "song_id":songID,
          }),
      );
      var resBodyMap = jsonDecode(res.body);
      if(res.statusCode != 200)
      {
        resBodyMap= resBodyMap as Map<String ,dynamic>;
        return Left(AppFailure(resBodyMap['detail']));
      }

      return Right(resBodyMap['message']);
    }
    catch(e){
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure,List<SongModel>>> getFavSongs({required String token})
  async{
    try{
      final res = await http.get(Uri.parse('${ServerConstant.serverURl}/song/list/favorites'),
          headers: {
            'content-Type':'application/json',
            'x-auth-token':token,
          },
      );
      var resBodyMap = jsonDecode(res.body);
      if(res.statusCode != 200)
      {
        resBodyMap= resBodyMap as Map<String ,dynamic>;
        return Left(AppFailure(resBodyMap['detail']));
      }
      List<SongModel> songs = []; //possible Error

      resBodyMap = resBodyMap as List;
      for(final map in resBodyMap){
        songs.add(SongModel.fromMap(map['song']));
      }
      return Right(songs);
    }
    catch(e){
      return Left(AppFailure(e.toString()));
    }
  }


}
