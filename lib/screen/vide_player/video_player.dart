import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:study/component/customer_video_file.dart';

class VideoPlayer extends StatefulWidget {
  VideoPlayer({super.key});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {

  XFile? videoFile;

  final boxDecoration = BoxDecoration(
    gradient: const LinearGradient(
      colors: [Color(0xFF2A3A7C), Color(0xFF000118)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: videoFile == null ? renderEmpty() : renderVideo())
    );
  }

  Widget renderVideo() {
    return Center(
      child: CustomVideoFile(
        video: this.videoFile!,
        onNewVideoPressed: onNewVideoPressed,
      ),
    );
  }

  Widget renderEmpty() {
    return Container(
      decoration: boxDecoration,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(
              onTap: onNewVideoPressed
          ),
          SizedBox(
            height: 30.0,
          ),
          _AppName()
        ],
      ),
    );
  }

  void onNewVideoPressed() async {
    // 사진첩 떠서 골라야 함으로 async여야함
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);

    if(video != null) {
      setState(() {
        this.videoFile = video;
      });
    }

  }

}

class _Logo extends StatelessWidget {

  final VoidCallback onTap;

  _Logo({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Image.asset('asset/img/logo.png'),
        onTap: this.onTap,
    );
  }
}

class _AppName extends StatelessWidget {
  const _AppName({super.key});

  @override
  Widget build(BuildContext context) {

    final textStyle = TextStyle(color: Colors.white);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'VIDEO',
          style: textStyle,
        ),
        Text(
          'PLAYER',
          style: textStyle.copyWith(
            // textStyle을 사용하면서 copyWith안에 선언된 것만 추가 적용함
              fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}
