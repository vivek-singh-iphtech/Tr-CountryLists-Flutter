import 'package:flutter/foundation.dart';

class Favorite extends ChangeNotifier {
  Map<int, bool> Fav = {};

  Map<int, bool> get getIsFav => Fav; //made the getter function for isFav

  bool isFav(int? id) {
    return Fav[id] ?? false;
  }

  void toggleFav(int? id) {
    Fav[id ?? -1] = !(Fav[id ?? -1] ?? false);
    notifyListeners(); //if the value of isFav changes then notify the listeners using this notifyListeners function().
  }
}
