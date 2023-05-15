import 'package:just_audio/just_audio.dart';

import 'notifiers/play_button_notifier.dart';
import 'notifiers/progress_notifier.dart';

class PageManager {
  final progressNotifier = ProgressNotifier();
  final playButtonNotifier = PlayButtonNotifier();
final String url;
  late AudioPlayer _audioPlayer;
  late ConcatenatingAudioSource _playlist;

  PageManager({required this.url}) {
    _init();
  }

  void _init() async {
    _audioPlayer = AudioPlayer();
    _setInitialPlaylist();
    _listenForChangesInPlayerState();
    _listenForChangesInPlayerPosition();
    _listenForChangesInBufferedPosition();
    _listenForChangesInTotalDuration();
  }

  void _setInitialPlaylist() async {
    _playlist = ConcatenatingAudioSource(children: [
      AudioSource.uri(Uri.parse(url),
          tag: 'Miyagi & Эндшпиль - Не теряя'),
    ]);
    await _audioPlayer.setAudioSource(_playlist);
  }

  void _listenForChangesInPlayerState() {
    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else {
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause();
      }
    });
  }

  void _listenForChangesInPlayerPosition() {
    _audioPlayer.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void _listenForChangesInBufferedPosition() {
    _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });
  }

  void _listenForChangesInTotalDuration() {
    _audioPlayer.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
  }

  void play() async {
    _audioPlayer.play();
  }

  void pause() {
    _audioPlayer.pause();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  void dispose() {
    _audioPlayer.dispose();
  }

  void onPreviousSongButtonPressed() {
    _audioPlayer.seek(Duration(
        seconds: (_audioPlayer.position.inSeconds / 10) > 0
            ? _audioPlayer.position.inSeconds - 10
            : (_audioPlayer.duration?.inSeconds ?? 0) -
                _audioPlayer.position.inSeconds));
  }

  void onNextSongButtonPressed() {
    _audioPlayer.seek(Duration(
        seconds: (_audioPlayer.duration?.inSeconds ?? 0) -
                    _audioPlayer.position.inSeconds >
                10
            ? _audioPlayer.position.inSeconds + 10
            : (_audioPlayer.duration?.inSeconds ?? 0) -
                _audioPlayer.position.inSeconds));
  }
//
// void onShuffleButtonPressed() async {
//   final enable = !_audioPlayer.shuffleModeEnabled;
//   if (enable) {
//     await _audioPlayer.shuffle();
//   }
//   await _audioPlayer.setShuffleModeEnabled(enable);
// }
//
// void addSong() {
//   final songNumber = _playlist.length + 1;
//   const prefix = 'https://www.soundhelix.com/examples/mp3';
//   final song = Uri.parse('$prefix/SoundHelix-Song-$songNumber.mp3');
//   _playlist.add(AudioSource.uri(song, tag: 'Song $songNumber'));
// }
//
// void removeSong() {
//   final index = _playlist.length - 1;
//   if (index < 0) return;
//   _playlist.removeAt(index);
// }

// void onRepeatButtonPressed() {
//   repeatButtonNotifier.nextState();
//   switch (repeatButtonNotifier.value) {
//     case RepeatState.off:
//       _audioPlayer.setLoopMode(LoopMode.off);
//       break;
//     case RepeatState.repeatSong:
//       _audioPlayer.setLoopMode(LoopMode.one);
//       break;
//     case RepeatState.repeatPlaylist:
//       _audioPlayer.setLoopMode(LoopMode.all);
//   }
// }
}
