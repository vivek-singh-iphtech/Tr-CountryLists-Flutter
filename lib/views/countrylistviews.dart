import 'package:country_lists/controllers/countrylistcontroller.dart';
import 'package:country_lists/models/countrylistmodel.dart';
import 'package:country_lists/providers/fav_provider.dart';
import 'package:country_lists/providers/favlist_provider.dart';
import 'package:country_lists/views/countrylistwebview.dart';
import 'package:country_lists/views/favcountryviews.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class CountryList extends StatefulWidget {
  const CountryList({super.key});

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  final CountryListController controller = CountryListController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Country Lists",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 22.0),
            child: Consumer<FavoriteCartList>(
              builder: (context, cart, _) => 
                badges.Badge(
                  badgeContent: Text('${cart.countryList.length}'),
                  position: badges.BadgePosition.topEnd(top: -1, end: -1),
                  child:IconButton(
                    icon: const Icon(
                      Icons.shopping_basket_sharp,
                      color: Color.fromARGB(195, 70, 120, 255),
                      size: 28,
                    ),
                    onPressed: () {
                      navigateToCartPage();
                    },
                  ),
                )
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: controller.fetchData(),
          builder: (context, AsyncSnapshot<List<CountryModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<CountryModel>? item = snapshot.data;
              return ListView.builder(
                  itemCount: item?.length,
                  itemBuilder: (context, int index) {
                    CountryModel? country = item?[index];
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
                                      color: Color.fromARGB(195, 70, 120, 255),
                                      size: 28,
                                    ),
                                    onPressed: () {
                                      Provider.of<Favorite>(context,
                                              listen: false)
                                          .toggleFav(country?.id);

                                      FavoriteCartList cart =
                                          Provider.of<FavoriteCartList>(context,
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
          },
        ),
      ),
    );
  }

  void _navigateToWebViewPage(CountryModel country) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WebViewPage(country)));
  }

  void navigateToCartPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FavcountryList()));
  }
}
