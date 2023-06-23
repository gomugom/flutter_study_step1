import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CustomVideoFile extends StatefulWidget {

  final XFile video;
  final VoidCallback onNewVideoPressed;

  const CustomVideoFile({required this.video, required this.onNewVideoPressed, super.key});

  @override
  State<CustomVideoFile> createState() => _CustomVideoFileState();
}

class _CustomVideoFileState extends State<CustomVideoFile> {

  VideoPlayerController? videoPlayerController;

  Duration currentPosition = Duration();

  bool showControls = false;

  @override
  void initState() {
    super.initState();

    initializeController();
  }

  // onNewVideoPressed의 경우 이미 initState가 불려있는 상태기 때문에 다시 initState가 불리지 않음
  // 따라서 바로 didUpdateWidget이 불리게 됨
  @override
  void didUpdateWidget(CustomVideoFile oldWidget) {
    
    super.didUpdateWidget(oldWidget);
    
    // 이전 위잿과 현재위잿의 path가 다를경우 다시 초기화
    if(oldWidget.video.path != widget.video.path) initializeController();
    
  }
  
  // video initialize하려면 async가 필요한대 initState에선 불가능 따라서 별도 함수로 빼서 작업한다.
  initializeController() async {

    currentPosition = Duration();

    videoPlayerController = VideoPlayerController.file(File(widget.video.path));

    await videoPlayerController!.initialize();

    // currentPosition값을 영상과 연결
    videoPlayerController!.addListener(() {
      final currentPosition = videoPlayerController!.value.position;

      setState(() {
        this.currentPosition = currentPosition;
      });
      
    });

    // 변경사항대로 빌드를 새로 하라는 의미로 setState를 호출해주어야 함
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (videoPlayerController == null) return CircularProgressIndicator();

    return AspectRatio(
      // video의 원래 비율대로 되도록
      aspectRatio: videoPlayerController!.value.aspectRatio,
      child: GestureDetector(
        onTap: () {
          setState(() {
            showControls = !showControls;
          });
        },
        child: Stack(
          children: [
            VideoPlayer(videoPlayerController!),
            if(showControls)
              _Controls(
                onReversePressed: onReversePressed,
                onPlayPressed: onPlayPressed,
                onForwardPressed: onForwardPressed,
                isPlaying: videoPlayerController!.value.isPlaying,
              ),
            if(showControls)
              _NewVideo(
                onPressed: widget.onNewVideoPressed,
              ),
            Positioned(
              bottom: 0,
              left: 0, // left, right를 둘다 0으로 주면 꽉 채우게 됨
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Text(
                      '${currentPosition.inMinutes}:${(currentPosition.inSeconds % 60).toString().padLeft(2, '0')}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0
                      ),
                    ),
                    Expanded(
                      child: Slider(
                          max: videoPlayerController!.value.duration.inSeconds.toDouble(),
                          min : 0,
                          value: currentPosition.inSeconds.toDouble(),
                          onChanged: (value) {
                            videoPlayerController!.seekTo(Duration(seconds: value.toInt()));
                            // setState(() {
                            //   currentPosition = Duration(seconds: value.toInt());
                            // });
                          },
                      ),
                    ),
                    Text(
                      '${videoPlayerController!.value.duration.inMinutes}:${(videoPlayerController!.value.duration.inSeconds % 60).toString().padLeft(2, '0')}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onReversePressed() {
    print('REVERSED!!!!!!!');
    final currentPosition = videoPlayerController!.value.position;

    Duration position = Duration();
    if(currentPosition.inSeconds > 3) {
      position = currentPosition - Duration(seconds: 3);
    }

    videoPlayerController!.seekTo(position);

  }

  void onPlayPressed() {
    print('onPlayPressed===========');
    // 이미 실행중이면 중지
    // 실행중이 아니면 실행
    setState(() {
      // icon 이미지 변경이 필요함으로
      if(videoPlayerController!.value.isPlaying) {
        print('PAUSE!!!');
        videoPlayerController!.pause();
      } else {
        print('START!!!');
        videoPlayerController!.play();
      }
    });

  }

  void onForwardPressed() {
    print('FORWARD!!!!!!!');
    final maxPosition = videoPlayerController!.value.duration;
    final currentPosition = videoPlayerController!.value.position;

    Duration position = maxPosition;

    if((maxPosition - Duration(seconds: 3)).inSeconds > currentPosition.inSeconds) {
      position = currentPosition + Duration(seconds: 3);
    }

    videoPlayerController!.seekTo(position);

  }

}

class _Controls extends StatelessWidget {

  final VoidCallback onPlayPressed;
  final VoidCallback onReversePressed;
  final VoidCallback onForwardPressed;
  final bool isPlaying;

  const _Controls({
    required this.onPlayPressed,
    required this.onReversePressed,
    required this.onForwardPressed,
    required this.isPlaying,
    super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.black.withOpacity(0.5), // 버튼이 보일 땐 주변부가 좀 어둡게 보이도록
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          renderIconButton(onPressed: this.onReversePressed, iconData: Icons.rotate_left),
          renderIconButton(onPressed: this.onPlayPressed,
              iconData: isPlaying ? Icons.pause : Icons.play_arrow
          ),
          renderIconButton(onPressed: this.onForwardPressed, iconData: Icons.rotate_right)
        ],
      ),
    );
  }
  
  Widget renderIconButton({required VoidCallback onPressed, required IconData iconData}) {
    return IconButton(
      iconSize: 30.0,
      color: Colors.white,
      onPressed: onPressed,
      icon: Icon(iconData),
    );
  }
  
}

class _NewVideo extends StatelessWidget {

  final VoidCallback onPressed;
  const _NewVideo({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned( // stack내에서 위치 조정할 수 있는 위젯
      right: 0,
      child: IconButton(
          color: Colors.white,
          iconSize: 30.0,
          onPressed: onPressed,
          icon: Icon(Icons.photo_camera_back)
      ),
    );
  }
}
