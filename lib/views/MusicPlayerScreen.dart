import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_player_/models/SongsModels.dart';

class MusicPlayerScreen extends StatefulWidget {
  final Song song;

  const MusicPlayerScreen({super.key, required this.song});

  @override
  _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  late AudioPlayer _audioPlayer;
  Duration? _duration;
  Duration _position = Duration.zero;
  bool isPlaying = false;
  bool isSliderChanging = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    _loadAudio();
    _audioPlayer.positionStream.listen((position) {
      if (!isSliderChanging) {
        setState(() {
          _position = position;
        });
      }
    });

    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          isPlaying = false;
        });
      }
    });
  }

  Future<void> _loadAudio() async {
    try {
      await _audioPlayer.setUrl(widget.song.audioUrl);
      _duration = await _audioPlayer.load();
      setState(() {});
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playPause() {
    setState(() {
      if (isPlaying) {
        _audioPlayer.pause();
      } else {
        _audioPlayer.play();
      }
      isPlaying = !isPlaying;
    });
  }

  void _skipNext() {
    print('Skip to next song');
  }

  void _skipPrevious() {
    print('Skip to previous song');
  }

  void _shuffleToggle() {
    _audioPlayer.setShuffleModeEnabled(!_audioPlayer.shuffleModeEnabled);
  }

  void _repeatToggle() {
    _audioPlayer.setLoopMode(
      _audioPlayer.loopMode == LoopMode.one ? LoopMode.off : LoopMode.one,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
              height: height,
              width: width,
              child: Stack(
                children: [
                  Image.network(
                    widget.song.imageUrl,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        _audioPlayer
                            .stop(); // Stop the audio when navigating back
                        Navigator.pop(context);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.white),
                      onPressed: () {
                        // Share functionality
                      },
                    ),
                  ],
                ),
              ),
              Hero(
                tag: 'song-${widget.song.title}',
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  height: height * 0.3, // Adjusted to fit the screen better
                  width: height * 0.3, // Adjusted to fit the screen better
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.0),
                    image: DecorationImage(
                      image: NetworkImage(widget.song.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Text(
                widget.song.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.song.artist,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
              Spacer(), // Pushes the bottom section upwards
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.shuffle, color: Colors.white),
                          onPressed: _shuffleToggle,
                        ),
                        IconButton(
                          icon: const Icon(Icons.skip_previous,
                              color: Colors.white),
                          onPressed: _skipPrevious,
                        ),
                        IconButton(
                          icon:
                              const Icon(Icons.skip_next, color: Colors.white),
                          onPressed: _skipNext,
                        ),
                        IconButton(
                          icon: const Icon(Icons.repeat, color: Colors.white),
                          onPressed: _repeatToggle,
                        ),
                      ],
                    ),
                    Slider(
                      min: 0,
                      max: _duration?.inSeconds.toDouble() ?? 1.0,
                      value: _position.inSeconds.toDouble(),
                      onChanged: _duration != null
                          ? (value) {
                              setState(() {
                                isSliderChanging = true;
                                _position = Duration(seconds: value.toInt());
                              });
                            }
                          : null,
                      onChangeEnd: (value) {
                        _audioPlayer.seek(Duration(seconds: value.toInt()));
                        setState(() {
                          isSliderChanging = false;
                        });
                      },
                      activeColor: Colors.orangeAccent,
                      inactiveColor: Colors.white38,
                    ),
                  ],
                ),
              ),
              // Adjusted the height of the play/pause button
              ElevatedButton(
                onPressed: _playPause,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                ),
                child: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              SizedBox(height: height * 0.03), // Reduced height
            ],
          ),
        ],
      ),
    );
  }
}
