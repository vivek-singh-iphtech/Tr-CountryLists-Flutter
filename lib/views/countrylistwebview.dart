import 'package:country_lists/models/countrylistmodel.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shimmer/shimmer.dart';

class WebViewPage extends StatefulWidget {
  final CountryModel? country;
  WebViewPage(this.country);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool isWebViewLoaded = false;

  late WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(NavigationDelegate(
      onPageFinished: (String url) {
        setState(() {
          isWebViewLoaded = true;
        });
      },
    ))
    ..loadRequest(Uri.parse(widget.country?.link ?? 'https://flutter.dev'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 233, 248, 255),
          title: Text(widget.country?.title ?? 'Title only')),
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(children: [
              WebViewWidget(
                controller: controller,
              ),
              if (!isWebViewLoaded)
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    color: Colors.white, // Adjust as needed
                  ),
                ),
            ])));
  }
}
