

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product_model.dart';
import '../services/product_service.dart';

final productDataProvider = FutureProvider<List<Product>>((ref) async{
  return ref.watch(productProvider).getProducts();
});

final menProductDataProvider = FutureProvider<List<Product>>((ref) async{
  return ref.watch(productProvider).getMenProducts();
});
final womenProductDataProvider = FutureProvider<List<Product>>((ref) async{
  return ref.watch(productProvider).getWomenProducts();
});



