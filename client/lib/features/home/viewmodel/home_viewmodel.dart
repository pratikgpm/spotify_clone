import 'dart:io';
import 'dart:ui';
import 'package:client/core/provider/current_user_notifier.dart';
import 'package:client/core/utils.dart';
import 'package:client/features/home/model/fav_song_model.dart';
import 'package:client/features/home/repositories/home_local_repository.dart';
import 'package:client/features/home/repositories/home_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/song_model.dart';

part 'home_viewmodel.g.dart';

@riverpod
Future<List<SongModel>> getAllSong(GetAllSongRef ref) async {
  final token = ref.watch(currentUserNotifierProvider.select((user) => user!.token));
  final res = await ref.watch(homeRepositoryProvider).getAllSongs(token: token);

  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}

@riverpod
Future<List<SongModel>> getFavSong(GetFavSongRef ref) async {
  final token = ref.watch(currentUserNotifierProvider.select((user) => user!.token));
  final res = await ref.watch(homeRepositoryProvider).getFavSongs(token: token);

  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}

@riverpod
class HomeViewModel extends _$HomeViewModel {
  late HomeRepository _homeRepository;
  late HomeLocalRepository _homeLocalRepository;

  @override
  AsyncValue? build() {
    _homeRepository = ref.watch(homeRepositoryProvider);
    _homeLocalRepository = ref.watch(homeLocalRepositoryProvider);
    return null;
  }

  Future<void> uploadSong({
    required File selectedAudio,
    required File selectedThumbnail,
    required String songName,
    required String artist,
    required Color selectedColor,
  }) async {
    state = const AsyncValue.loading();
    final res = await _homeRepository.uploadSong(
        selectedAudio: selectedAudio,
        selectedThumbnail: selectedThumbnail,
        songName: songName,
        artist: artist,
        hexCode: rgbToHex(selectedColor),
        token: ref.read(currentUserNotifierProvider)!.token);
    final val = switch (res) {
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => state = AsyncValue.data(r)
    };
  }

  List<SongModel> getRecentlyPlayedSongs() {
    return _homeLocalRepository.loadSong();
  }

  Future<void> favSong({
    required String songId,
  }) async {
    state = const AsyncValue.loading();
    final res = await _homeRepository.favSongs(
        token: ref.read(currentUserNotifierProvider)!.token, songID: songId);
    final val = switch (res) {
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => state = _favSongSucess(r,songId),
    };
  }

  AsyncValue _favSongSucess(bool isFavorited, String songId) {
    final userNotifier = ref.read(currentUserNotifierProvider.notifier);
    if (isFavorited) {
      userNotifier.addUser(
        ref.read(currentUserNotifierProvider)!.copyWith(
          favorites: [
            ...ref.read(currentUserNotifierProvider)!.favorites,
            FavSongModel(
              id: '',
              user_id: '',
              song_id: songId,
            ),
          ],
        ),
      );
    } else {
      userNotifier.addUser(
        ref.read(currentUserNotifierProvider)!.copyWith(
              favorites: ref
                  .read(currentUserNotifierProvider)!
                  .favorites
                  .where((fav) => fav.song_id != songId)
                  .toList(),
            ),
      );
    }
    ref.invalidate(getFavSongProvider);
    return state = AsyncValue.data(isFavorited);
  }
}
