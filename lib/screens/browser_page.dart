import 'package:adblocked_webview/controllers/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowserPage extends StatefulWidget {
  final String? url;
  const BrowserPage({super.key, this.url});

  @override
  State<BrowserPage> createState() => _BrowserPageState();
}

class _BrowserPageState extends State<BrowserPage> {
  WebViewController? _webViewController;
  bool isShowTool = false;
  final dataController = Get.find<DataController>();

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isShowTool
          ? AppBar(
              title: Text('Browsing'),
              actions: [
                GestureDetector(
                  onTap: () {
                    _webViewController!.goBack();
                  },
                  child: Icon(Icons.arrow_back),
                ),
                SizedBox(width: 30),
                GestureDetector(
                  onTap: () {
                    _webViewController!.goForward();
                  },
                  child: Icon(Icons.arrow_forward),
                ),
                SizedBox(width: 30),
                GestureDetector(
                  onTap: () {
                    _webViewController!.reload();
                  },
                  child: Icon(Icons.refresh),
                ),
                SizedBox(width: 15),
              ],
            )
          : null,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isShowTool) {
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
          } else {
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
          }
          setState(() {
            isShowTool = !isShowTool;
          });
        },
        child: Icon(
          Icons.apps,
          color: Colors.white.withOpacity(0.5),
        ),
        backgroundColor: Colors.teal.withOpacity(0.5),
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _webViewController = webViewController;
        },
        navigationDelegate: (navigation) {
          // if (navigation.url.compareTo(widget.url!) > 0) {
          List<String> url = widget.url!.split('.');
          // log(url[1]);
          // print('${url[0]}.${url[1]}');
          if (!navigation.url.contains('${url[0]}.${url[1]}')) {
            return NavigationDecision.prevent;
          } else {
            // dataController.visitHistory.add(navigation.url);
            // dataController.visitHistory.insert(0, navigation.url);
            dataController.addVisitHistory(navigation.url);
            return NavigationDecision.navigate;
          }
        },
      ),
    );
  }
}
