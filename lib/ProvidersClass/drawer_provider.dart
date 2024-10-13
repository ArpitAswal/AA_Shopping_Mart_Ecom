
import 'package:aa_shopping_mart/DataModel/sale_items_model.dart';
import 'package:aa_shopping_mart/GlobalData/sale_items_data.dart';
import 'package:flutter/widgets.dart';

class DrawerProvider extends ChangeNotifier{

  late List<SaleItemsModel> _selectedList = [];

  List<SaleItemsModel> get selectedList => _selectedList;

  set selectList(String listName) {
    if(listName == "SaleItems"){
      _selectedList = SaleItemsData.saleItemsList;
    }
  }
}