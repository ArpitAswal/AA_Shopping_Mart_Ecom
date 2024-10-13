import 'package:aa_shopping_mart/DataModel/products_model.dart';
import 'package:aa_shopping_mart/Repository/products_repositories.dart';
import 'package:aa_shopping_mart/Utils/app_exceptions.dart';
import 'package:flutter/material.dart';


class ProductsProvider extends ChangeNotifier {
  final _service = ProductsRepositories();

  List<ProductModel> _productsList = [];
  bool isLoading = false;
  int prodCurrentLimit = 12;

  late ProductModel? _singleProduct;

  List<ProductModel> get productsList => _productsList;
  List<ProductModel> get searchList => _productsList;
  ProductModel? get singleProduct => _singleProduct;

  Future<void> getAllProducts() async {
    _productsList.clear();
    notifyListeners();
    try {
      final response = await _service.getProducts();
      _productsList = response;
      notifyListeners();
    } on AppException catch (e) {
      throw AppException(message: e.message, type: e.type);
    }
  }

  Future<ProductModel> getSingleProduct(int prodId) async {
    try {
      return await _service.getProductInfo(prodId);
    } on AppException catch (e) {
      throw AppException(message: e.message, type: e.type);
    }
  }

  Future<void> loadMore() async {
    isLoading = true;
    notifyListeners();

    if (prodCurrentLimit < productsList.length) {
      prodCurrentLimit = (prodCurrentLimit + 8 >= productsList.length)
          ? productsList.length
          : prodCurrentLimit + 8;
    }
    await Future.delayed(const Duration(seconds: 2));
    isLoading = false;
    notifyListeners();
  }
}
