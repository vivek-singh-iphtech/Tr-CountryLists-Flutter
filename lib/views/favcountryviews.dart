import 'package:country_lists/providers/fav_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/countrylistmodel.dart';
import '../providers/favlist_provider.dart';
import 'countrylistwebview.dart';

class FavcountryList extends StatefulWidget {
  const FavcountryList({Key? key}) : super(key: key);

  @override
  _FavcountryListState createState() => _FavcountryListState();
}

class _FavcountryListState extends State<FavcountryList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Favorite Country Lists",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<FavoriteCartList>(builder: (context, cart, child) {
              if (cart.countryList.isEmpty) {
                return Center(
                    child: Image.asset(
                      'assets/images/empty.png',
                      width: 300,
                      height: 300,
                    )
                    );
              } else {
                return ListView.builder(
                    itemCount: cart.countryList.length,
                    itemBuilder: (context, int index) {
                      CountryModel? country = cart.countryList[index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                            tileColor: Color.fromARGB(255, 233, 248, 255),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 2, color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onTap: () {
                              _navigateToWebViewPage(country!);
                            },
                            leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage(country?.image ?? "null problem"),
                            ),
                            title: Text(
                              country?.title ?? 'null problem',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            subtitle: Text(
                              country?.subtitle ?? 'null problem',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 151, 155, 178),
                                fontSize: 14,
                              ),
                            ),
                            trailing: Consumer<Favorite>(
                                builder: (context, favorite, _) => IconButton(
                                      icon: Icon(
                                        favorite.isFav(country?.id)
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color:
                                            Color.fromARGB(195, 70, 120, 255),
                                        size: 28,
                                      ),
                                      onPressed: () {
                                        Provider.of<Favorite>(context,
                                                listen: false)
                                            .toggleFav(country?.id);

                                        FavoriteCartList cart =
                                            Provider.of<FavoriteCartList>(
                                                context,
                                                listen: false);

                                        if (favorite.isFav(country?.id)) {
                                          cart.addToCart(country);
                                        } else {
                                          cart.removeFromCart(country);
                                        }
                                      },
                                    ))),
                      );
                    });
              }
            })));
  }

  void _navigateToWebViewPage(CountryModel country) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WebViewPage(country)));
  }
}
