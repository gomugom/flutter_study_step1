import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPrac extends StatelessWidget {
  WebViewPrac({super.key});

  WebViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'Code Factory',
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                print('클릭!');
                if(controller == null) return;
                controller!.loadUrl('https://blog.codefactory.ai');
              },
              icon: Icon(
                Icons.home,
              ))
        ],
      ),
      body: WebView(
        onWebViewCreated: (WebViewController controller) {
          this.controller = controller;
        },
        initialUrl: 'https://blog.codefactory.ai',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
