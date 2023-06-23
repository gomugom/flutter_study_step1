// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// class VideoScreenPrac extends StatefulWidget {
//   final String videoPath;
//
//   const VideoScreenPrac({required this.videoPath, super.key});
//
//   @override
//   State<VideoScreenPrac> createState() => _VideoScreenPracState();
// }
//
// class _VideoScreenPracState extends State<VideoScreenPrac> {
//
//   VideoPlayerController? videoPlayerController;
//
//   Duration currentPosition = Duration();
//
//   @override
//   void initState() {
//     super.initState();
//
//     initialVideoPlayer();
//   }
//
//   void initialVideoPlayer() async {
//     videoPlayerController = VideoPlayerController.file(File(widget.videoPath));
//
//     await videoPlayerController?.initialize();
//
//     // video 위치가 변할 때마다 호출을 감지하는 리스너
//     videoPlayerController!.addListener(() {
//       setState(() {
//         currentPosition = videoPlayerController!.value.position;
//       });
//     },);
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (videoPlayerController == null) return CircularProgressIndicator();
//
//     return Container(
//       color: Colors.white,
//       width: MediaQuery.of(context).size.width,
//       child: Center(
//         child: AspectRatio(
//           aspectRatio: videoPlayerController!.value.aspectRatio,
//           child: Stack(children: [
//             VideoPlayer(videoPlayerController!),
//             _Controls(
//               onLeftPressed: onPrevPressed,
//               onPlayPressed: onPlayPressed,
//               onRightPressed: onNextPressed,
//               isPlaying: videoPlayerController!.value.isPlaying,
//             ),
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: _Slider(
//                 maxTime:
//                     videoPlayerController!.value.duration.inSeconds.toDouble(),
//                 currentTime: currentPosition!.inSeconds.toDouble(),
//                 onSliderChanged: onSliderValueChanged,
//               ),
//             )
//           ]),
//         ),
//       ),
//     );
//   }
//
//   void onSliderValueChanged(double value) {
//
//     videoPlayerController!.seekTo(Duration(seconds: value.toInt()));
//
//   }
//
//   void onPrevPressed() {
//     Duration position;
//
//     Duration currentPosition = videoPlayerController!.value.position;
//
//     position = currentPosition - Duration(seconds: 3);
//
//     if (position.inSeconds < 0) position = Duration(seconds: 0);
//
//     videoPlayerController!.seekTo(position);
//   }
//
//   void onPlayPressed() {
//     print('onPlayPressed !!================');
//     setState(() {
//       if (videoPlayerController!.value.isPlaying) {
//         videoPlayerController!.pause();
//       } else {
//         videoPlayerController!.play();
//       }
//     });
//   }
//
//   void onNextPressed() {
//     Duration position;
//
//     Duration currentPosition = videoPlayerController!.value.position;
//
//     position = currentPosition + Duration(seconds: 3);
//
//     if (position.inSeconds > videoPlayerController!.value.duration.inSeconds)
//       position = videoPlayerController!.value.duration;
//
//     videoPlayerController!.seekTo(position);
//   }
// }
//
// class _Controls extends StatelessWidget {
//   final VoidCallback onLeftPressed;
//   final VoidCallback onPlayPressed;
//   final VoidCallback onRightPressed;
//   final bool isPlaying;
//
//   const _Controls(
//       {required this.onLeftPressed,
//       required this.onPlayPressed,
//       required this.onRightPressed,
//       required this.isPlaying,
//       super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.black.withOpacity(0.5),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           renderIconButton(
//             iconData: Icons.rotate_left,
//             onPressed: onLeftPressed,
//           ),
//           renderIconButton(
//             iconData: isPlaying ? Icons.pause : Icons.play_arrow,
//             onPressed: onPlayPressed,
//           ),
//           renderIconButton(
//             iconData: Icons.rotate_right,
//             onPressed: onRightPressed,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget renderIconButton(
//       {required IconData iconData, required VoidCallback onPressed}) {
//     return IconButton(
//         color: Colors.white,
//         iconSize: 30.0,
//         onPressed: onPressed,
//         icon: Icon(iconData));
//   }
// }
//
// class _Slider extends StatelessWidget {
//   final double maxTime;
//   final double currentTime;
//   final ValueChanged<double> onSliderChanged;
//
//   const _Slider(
//       {required this.maxTime,
//       required this.currentTime,
//       required this.onSliderChanged,
//       super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Slider(
//       min: 0,
//       max: maxTime,
//       value: currentTime,
//       onChanged: onSliderChanged,
//     );
//   }
// }
