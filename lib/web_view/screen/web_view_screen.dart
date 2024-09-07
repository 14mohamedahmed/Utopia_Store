import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:utopia_store/utils/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({required this.url, super.key});

  final String url;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Constants.mainColor),
    );
    controller = WebViewController()
      ..canGoBack()
      ..canGoForward()
      ..enableZoom(true)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
            onProgress: (progress) {
              debugPrint('progress: $progress');
            },
            onPageStarted: (url) {
              debugPrint('Page started loading: $url');
            },
            onPageFinished: (url) {}),
      );

    controller.loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();
          return false;
        }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: WebViewWidget(
            controller: controller,
            gestureRecognizers: {
              Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
              ),
            },
          ),
        ),
      ),
    );
  }
}
