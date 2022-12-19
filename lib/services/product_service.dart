import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

import '../helper/constant.dart';
import '../models/product_model.dart';

class ApiServices{

  Future <List<Product>> getProducts() async {
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200){
      final List products = jsonDecode(response.body);
      return products.map(((e) => Product.fromJson(e))).toList();
    }else{
      throw Exception(response.reasonPhrase);
    }
  }

  Future <List<Product>> getMenProducts() async {
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200){
      final List productsMen = jsonDecode(response.body);
      return productsMen.map(((e) => Product.fromJson(e))).where((item) => item.category == 'men\'s clothing').toList();
    }else{
      throw Exception(response.reasonPhrase);
    }
  }

  Future <List<Product>> getWomenProducts() async {
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200){
      final List productsMen = jsonDecode(response.body);
      return productsMen.map(((e) => Product.fromJson(e))).where((item) => item.category == 'women\'s clothing').toList();
    }else{
      throw Exception(response.reasonPhrase);
    }
  }
 
}

final productProvider =  Provider<ApiServices>(((ref) => ApiServices()));
