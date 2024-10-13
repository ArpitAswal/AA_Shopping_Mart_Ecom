import 'dart:async';
import 'dart:io';

import 'package:aa_shopping_mart/DataModel/products_model.dart';
import 'package:aa_shopping_mart/Utils/jsonResponse.dart';
import 'package:http/http.dart' as http;

import '../Utils/api_urls.dart';
import '../Utils/app_exceptions.dart';

class CategoryRepo{

  Future<List<dynamic>> fetchCategories() async{

    try{
      final response = await http.get(Uri.parse(ApiUrls.getCategories));
      final result = jsonResponse(response);
      return result;
    } on SocketException {
      throw AppException(
          message: 'No Internet connection', type: ExceptionType.internet);
    } on HttpException {
      throw AppException(
          message: "Couldn't find the data", type: ExceptionType.http);
    } on FormatException {
      throw AppException(
          message: "Bad response format", type: ExceptionType.format);
    } on TimeoutException {
      throw AppException(
        message: 'Connection timed out',
        type: ExceptionType.timeout,
      );
    } catch (e) {
      throw AppException(message: e.toString(), type: ExceptionType.api);
    }
  }

  Future<List<ProductModel>> fetchCategoryItem(String? selectedCategory) async{
      try{
        List<ProductModel> data = [];
        final response = await http.get(Uri.parse("${ApiUrls.getCategoryItem}/$selectedCategory"));
        final result = jsonResponse(response);
        if (result != null) {
          for (var prd in result) {
            data.add(ProductModel.fromJson(prd));
          }
          return data;
        } else{
          return data;
        }
      }  on SocketException {
        throw AppException(
            message: 'No Internet connection', type: ExceptionType.internet);
      } on HttpException {
        throw AppException(
            message: "Couldn't find the data", type: ExceptionType.http);
      } on FormatException {
        throw AppException(
            message: "Bad response format", type: ExceptionType.format);
      } on TimeoutException {
        throw AppException(
          message: 'Connection timed out',
          type: ExceptionType.timeout,
        );
      } catch (e) {
        throw AppException(message: e.toString(), type: ExceptionType.api);
      }
  }
}