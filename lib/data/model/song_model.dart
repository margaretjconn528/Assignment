import 'package:music_player/domain/entities/song.dart';

class SongModel extends Song {
  const SongModel({
    required super.title,
    required super.artist,
    required super.url,
    required super.durationSeconds,
  });

  static List<Song> getSampleSongs() {
    return const [
      SongModel(
        title: 'Lofi Study',
        artist: 'FASSounds',
        url:
            'https://cdn.pixabay.com/download/audio/2022/05/27/audio_1808fbf07a.mp3',
        durationSeconds: 146,
      ),
      SongModel(
        title: 'Good Night',
        artist: 'FASSounds',
        url:
            'https://cdn.pixabay.com/download/audio/2022/10/14/audio_9939f792cb.mp3',
        durationSeconds: 147,
      ),
      SongModel(
        title: 'Cinematic Time Lapse',
        artist: 'Lexin_Music',
        url:
            'https://cdn.pixabay.com/download/audio/2022/08/02/audio_884fe92c21.mp3',
        durationSeconds: 135,
      ),

      // NEW SONGS

      SongModel(
        title: 'Dreams',
        artist: 'Ashot-Danielyan',
        url:
            'https://cdn.pixabay.com/download/audio/2022/03/15/audio_c8c8a73467.mp3',
        durationSeconds: 182,
      ),
      SongModel(
        title: 'Epic Cinematic',
        artist: 'AlexGrohl',
        url:
            'https://cdn.pixabay.com/download/audio/2022/03/09/audio_9f4f3f8c3e.mp3',
        durationSeconds: 201,
      ),
      SongModel(
        title: 'Inspiring Piano',
        artist: 'LiteSaturation',
        url:
            'https://cdn.pixabay.com/download/audio/2022/11/03/audio_0cfa4b87f6.mp3',
        durationSeconds: 164,
      ),
      SongModel(
        title: 'Ambient Relax',
        artist: 'SoulProdMusic',
        url:
            'https://cdn.pixabay.com/download/audio/2022/03/24/audio_2cf0a7e5a2.mp3',
        durationSeconds: 173,
      ),
      SongModel(
        title: 'Chill Beat',
        artist: 'ComaStudio',
        url:
            'https://cdn.pixabay.com/download/audio/2022/05/16/audio_4b7c9e1e4b.mp3',
        durationSeconds: 158,
      ),
      SongModel(
        title: 'Summer Vibes',
        artist: 'Music_For_Videos',
        url:
            'https://cdn.pixabay.com/download/audio/2022/07/04/audio_3e64a7b2b7.mp3',
        durationSeconds: 192,
      ),
      SongModel(
        title: 'Night Drive',
        artist: 'ComaStudio',
        url:
            'https://cdn.pixabay.com/download/audio/2022/06/14/audio_1cb0f7e33a.mp3',
        durationSeconds: 176,
      ),
      SongModel(
        title: 'Future Bass',
        artist: 'SoulProdMusic',
        url:
            'https://cdn.pixabay.com/download/audio/2022/04/27/audio_8a4c6e6b1f.mp3',
        durationSeconds: 188,
      ),
      SongModel(
        title: 'Soft Piano',
        artist: 'LiteSaturation',
        url:
            'https://cdn.pixabay.com/download/audio/2022/10/03/audio_65a5d7f9d1.mp3',
        durationSeconds: 149,
      ),
      SongModel(
        title: 'Adventure',
        artist: 'AlexGrohl',
        url:
            'https://cdn.pixabay.com/download/audio/2022/01/20/audio_febc508f9c.mp3',
        durationSeconds: 205,
      ),
    ];
  }
}