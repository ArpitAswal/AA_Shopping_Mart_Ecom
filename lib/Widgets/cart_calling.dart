import 'package:aa_shopping_mart/GlobalData/CartProducts.dart';
import 'package:flutter/widgets.dart';


class CartCalling with ChangeNotifier{
  static final List<CartProducts> _lst = [];
  static  int _count=0;

  add(int? id, String? title, double? price, String? description, String? category, String? image) {

    _lst.add(CartProducts(id:id,title:title,price: price,description: description,category: category,image: image));
  debugPrint(_lst.length.toString());
  _count++;
  notifyListeners();
  }

  void del(int? id) {
    _count--;
    debugPrint('productId= $id');
    debugPrint(_lst.length.toString());
    for(int i=0;i<_lst.length;i++){
      if(_lst[i].id==id) {
        _lst.removeAt(i);
      }
    }
    debugPrint(_lst.length.toString());
   notifyListeners();
  }

  List get lst => _lst;
  int get count => _count;

}