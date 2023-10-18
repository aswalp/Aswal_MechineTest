import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/Itemmodel.dart';

class CartNotifier extends ChangeNotifier {
  List<CategoryDish> _cartlist = [];

  List<CategoryDish> get cartlist => _cartlist;

  void addtcart(CategoryDish data) {
    // Check if the cart is empty
    if (_cartlist.isEmpty) {
      data = data.copyWith(itemcount: 1);
      _cartlist.add(data);
    } else {
      // Flag to indicate whether the item was found in the cart
      bool itemFound = false;

      for (var item in _cartlist) {
        if (item.dishId == data.dishId) {
          // If the item is already in the cart, increment the item count
          item.itemcount++;
          itemFound = true;
          break; // No need to continue searching
        }
      }

      // If the item was not found in the cart, add it with a count of 1
      if (!itemFound) {
        data = data.copyWith(itemcount: 1);
        _cartlist.add(data);
      }
    }

    notifyListeners();
  }

  void removefromcart(CategoryDish data) {
    for (var i in _cartlist) {
      if (i.dishId == data.dishId) {
        if (i.itemcount > 1) {
          i.itemcount--;
        } else {
          _cartlist.remove(i);
        }
        notifyListeners();
        break; // Stop after the first occurrence of the item is modified
      }
    }
  }

  int? itemcount(String id) {
    for (var i in _cartlist) {
      if (id == i.dishId) {
        return i.itemcount;
      }
    }

    if (_cartlist.isEmpty) {
      return 0;
    }

    return null;
  }

  double totalprice() {
    double sum = 0;
    for (var i in _cartlist) {
      sum = sum + i.dishPrice! * i.itemcount;
    }

    return sum;
  }

  void clearlist() {
    _cartlist = [];
    notifyListeners();
  }
}

final cartProvider = ChangeNotifierProvider<CartNotifier>((ref) {
  return CartNotifier();
});

final totalItemProvider = StateProvider<int>((ref) {
  return 0;
});
