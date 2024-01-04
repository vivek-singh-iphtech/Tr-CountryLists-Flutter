import 'package:country_lists/models/countrylistmodel.dart';
import 'package:country_lists/providers/fav_provider.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';

import '../providers/favlist_provider.dart';

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
          title: Text(
            widget.country?.title ?? 'Title only',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 22.0),
                child: Consumer<Favorite>(
                    builder: (context, favorite, _) => IconButton(
                          icon: Icon(
                            favorite.isFav(widget.country?.id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: const Color.fromARGB(195, 70, 120, 255),
                            size: 28,
                          ),
                          onPressed: () {
                            Provider.of<Favorite>(context, listen: false)
                                .toggleFav(widget.country?.id);

                              FavoriteCartList cart =
                                          Provider.of<FavoriteCartList>(context,
                                              listen: false);

                                      if (favorite.isFav(widget.country?.id)) {
                                        cart.addToCart(widget.country);
                                      } else {
                                        cart.removeFromCart(widget.country);
                                      }
                          },
                        ))),
          ],
        ),
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
