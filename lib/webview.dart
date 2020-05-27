import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
      import 'package:new_app/drawer.dart';

class Webview extends StatefulWidget {
  
  final String url;
  Webview({this.url});
  
  @override
  _WebviewState createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
      child: SideDrawer(),
    ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text("Stay",style: TextStyle(fontSize: 20, fontFamily: 'ChelseaMarket',fontWeight: FontWeight.bold)),
          Text("Updated",style: TextStyle(fontSize: 25,fontFamily: 'ChelseaMarket', color: Colors.yellow, fontWeight: FontWeight.bold))
        ],
        ),
      ),
      body : Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl: widget.url,
          onWebViewCreated: ((WebViewController webViewController) {
            _controller.complete(webViewController);
          }),
        ),
      ),
    );
  }

}