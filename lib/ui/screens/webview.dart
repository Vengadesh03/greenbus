import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BannerView extends StatefulWidget {
  final navlink;

  const BannerView({Key key, this.navlink}) : super(key: key);
  // const BannerView({ Key? key }) : super(key: key);

  @override
  _BannerViewState createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {
   Completer<WebViewController> _controller = Completer<WebViewController>();
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
       
        body:   WebView(
            initialUrl: widget.navlink,
            javascriptMode: JavascriptMode.unrestricted,
          ),
      ),
    );
  }
}