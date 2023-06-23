import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler extends StatefulWidget {
  const PermissionHandler({super.key});

  @override
  State<PermissionHandler> createState() => _PermissionHandlerState();
}

class _PermissionHandlerState extends State<PermissionHandler> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton.icon(
            onPressed: () {}, icon: Icon(Icons.videocam), label: Text('LIVE')),
        FutureBuilder<bool>(
          future: init(),
          builder: (context, snapshot) {

            if(snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            if(!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue[300]!,
                      blurRadius: 12.0,
                      spreadRadius: 2.0
                    )
                  ]),
              color: Colors.blue,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [Icon(Icons.videocam), Text('LIVE')],
              ),
            );
          }
        )
      ],
    );
  }

  Future<bool> init() async {

    final resp = await [Permission.camera, Permission.microphone].request();

    final cameraPermission = resp[Permission.camera];
    final microphonePermission = resp[Permission.microphone];

    if(cameraPermission != PermissionStatus.granted
      || microphonePermission != PermissionStatus.granted
    ) {
      throw '카메라 또는 마이크 권한이 없습니다.';
    }

    return true;

  }

}
