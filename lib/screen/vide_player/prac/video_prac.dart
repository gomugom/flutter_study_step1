// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:study/screen/vide_player/prac/component/video_screen_prac.dart';
//
// class VideoPrac extends StatefulWidget {
//   const VideoPrac({super.key});
//
//   @override
//   State<VideoPrac> createState() => _VideoPracState();
// }
//
// class _VideoPracState extends State<VideoPrac> {
//
//   XFile? video;
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(body: SafeArea(child: video == null ? renderEmpty() : VideoScreenPrac(videoPath: video!.path,)));
//
//   }
//
//   Widget renderEmpty() {
//
//     final txtStyle = const TextStyle(color: Colors.white, fontSize: 30.0);
//
//     BoxDecoration getBoxDecoration() {
//       return const BoxDecoration(
//           gradient: LinearGradient(
//               colors: [Colors.blue, Colors.white],
//               begin: Alignment.bottomCenter,
//               end: Alignment.topCenter));
//     }
//
//     return Container(
//       decoration: getBoxDecoration(),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           _LogoImage(
//             onPressed: onLogoPressed,
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'VIDEO',
//                 style: txtStyle,
//               ),
//               Text(
//                 'PLAYER',
//                 style: txtStyle.copyWith(
//                     fontWeight: FontWeight.bold, color: Colors.yellowAccent),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   void onLogoPressed() async {
//
//     final ImagePicker picker = ImagePicker();
//
//     final XFile? videoFile = await picker.pickVideo(source: ImageSource.gallery);
//
//     if(videoFile != null) {
//
//       setState(() {
//         video = videoFile;
//       });
//
//     }
//
//   }
// }
//
// class _LogoImage extends StatelessWidget {
//
//   final VoidCallback onPressed;
//
//   const _LogoImage({required this.onPressed, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: this.onPressed,
//       child: Image.asset('asset/img/logo.png'),
//     );
//   }
// }
