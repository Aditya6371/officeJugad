import 'package:flutter/material.dart';
import 'package:zero_admin/utils/utils.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  final String videoTitle;

  const VideoPlayerScreen({
    super.key,
    required this.videoUrl,
    required this.videoTitle,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    _controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.videoTitle),
      ),
      body: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
          progressColors: const ProgressBarColors(
            playedColor: Colors.blue,
            handleColor: Colors.blueAccent,
          ),
          onReady: () {
            AppLog.info('Player is ready.');
          },
          bottomActions: const [
            CurrentPosition(),
            ProgressBar(isExpanded: true),
            RemainingDuration(),
            FullScreenButton(),
          ],
        ),
        builder: (context, player) {
          return Column(
            children: [
              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: player,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
