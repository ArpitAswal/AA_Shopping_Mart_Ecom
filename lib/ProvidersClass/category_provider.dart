import 'package:aa_shopping_mart/DataModel/products_model.dart';
import 'package:aa_shopping_mart/Repository/category_repo.dart';
import 'package:aa_shopping_mart/Utils/app_exceptions.dart';
import 'package:flutter/material.dart';


class CategoryProvider with ChangeNotifier {
  final _service = CategoryRepo();

  final List<String> _categoryList = [];
  List<ProductModel> _categoryItemsList = [];
  String? _selectedCategory;
  bool isLoading = false;
  int categoryLimit = 12;

  List<String> get categoryList => _categoryList;
  List<ProductModel> get categoryItemsList => _categoryItemsList;
  String? get selectedCategory => _selectedCategory;

  set selectCategory(String? value) => _selectedCategory = value;

  Future<void> fetchCategories() async {
    // Fetch categories from API
    try {
      var result = await _service.fetchCategories();
      _categoryList.clear();
      result.forEach((value) {
        _categoryList.add(value.toString().capitalize());
      });
      notifyListeners();
    } on AppException catch (e) {
      throw AppException(message: e.message, type: e.type);
    }
  }

  Future<void> fetchCategoryItems(String value) async {
    try {
      _selectedCategory = value;
      _categoryItemsList = await _service.fetchCategoryItem(selectedCategory?.toLowerCase());
      if (_categoryItemsList.length < 12) {
        categoryLimit = _categoryItemsList.length;
      } else {
        categoryLimit = 12;
      }
      notifyListeners();
    } on AppException catch (e) {
      throw AppException(message: e.message, type: e.type);
    }
  }

  Future<void> loadMore() async {
    isLoading = true;
    notifyListeners();

    if (categoryLimit < categoryItemsList.length) {
      categoryLimit = (categoryLimit + 8 >= categoryItemsList.length)
          ? categoryItemsList.length
          : categoryLimit + 8;
    } else {
      categoryLimit = categoryItemsList.length;
    }
    await Future.delayed(const Duration(seconds: 2));
    isLoading = false;
    notifyListeners();
  }

  void removeCategoryItems() {
    _selectedCategory = null;
    _categoryItemsList = [];
    notifyListeners();
  }
}

extension StringExtensions on String {
  String capitalize() {
    String newString = "";
    for (String word in split(" ")) {
      newString += "${word[0].toUpperCase()}${word.substring(1)} ";
    }
    return newString.trim();
  }
}
