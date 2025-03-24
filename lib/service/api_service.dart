import 'dart:convert';
import 'package:hava_havai_hiring_challenge/models/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://dummyjson.com/products';

  Future<List<Product>> fetchProducts({int limit = 10, int skip = 0}) async {
    final url = '$baseUrl?limit=$limit&skip=$skip';
    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> productList = data['products'];
      return productList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}