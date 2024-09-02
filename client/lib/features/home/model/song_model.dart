// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SongModel {
  final String song_url;
  final String artist;
  final String thumbnail_url;
  final String hex_code;
  final String song_name;
  final String id;
  SongModel({
    required this.song_url,
    required this.artist,
    required this.thumbnail_url,
    required this.hex_code,
    required this.song_name,
    required this.id,
  });

  SongModel copyWith({
    String? song_url,
    String? artist,
    String? thumbnail_url,
    String? hex_code,
    String? song_name,
    String? id,
  }) {
    return SongModel(
      song_url: song_url ?? this.song_url,
      artist: artist ?? this.artist,
      thumbnail_url: thumbnail_url ?? this.thumbnail_url,
      hex_code: hex_code ?? this.hex_code,
      song_name: song_name ?? this.song_name,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'song_url': song_url,
      'artist': artist,
      'thumbnail_url': thumbnail_url,
      'hex_code': hex_code,
      'song_name': song_name,
      'id': id,
    };
  }

  factory SongModel.fromMap(Map<String, dynamic> map) {
    return SongModel(
      song_url: map['song_url'] ?? '',
      artist: map['artist'] ?? '',
      thumbnail_url: map['thumbnail_url'] ?? '',
      hex_code: map['hex_code'] ?? '',
      song_name: map['song_name'] ?? '',
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SongModel.fromJson(String source) =>
      SongModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SongModel(song_url: $song_url, artist: $artist, thumbnail_url: $thumbnail_url, hex_code: $hex_code, song_name: $song_name, id: $id)';
  }

  @override
  bool operator ==(covariant SongModel other) {
    if (identical(this, other)) return true;

    return other.song_url == song_url &&
        other.artist == artist &&
        other.thumbnail_url == thumbnail_url &&
        other.hex_code == hex_code &&
        other.song_name == song_name &&
        other.id == id;
  }

  @override
  int get hashCode {
    return song_url.hashCode ^
        artist.hashCode ^
        thumbnail_url.hashCode ^
        hex_code.hashCode ^
        song_name.hashCode ^
        id.hashCode;
  }
}
