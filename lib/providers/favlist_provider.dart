import 'package:country_lists/models/countrylistmodel.dart';
import 'package:flutter/foundation.dart';

class FavoriteCartList extends ChangeNotifier {
 
 List<CountryModel?> countryList = [];

  List<CountryModel?> get countryCart => countryList;

  void addToCart(CountryModel? items)
  {
    countryList.add(items);
    notifyListeners();
  }

  void removeFromCart(CountryModel? items)
  {
    countryList.remove(items);
    notifyListeners();
  }

 
}  
