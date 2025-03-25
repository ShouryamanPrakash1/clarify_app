import 'dart:convert';
import 'package:cartify_app/model/items.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Product>> fetchProducts({int limit = 0, int skip = 0}) async {
    final uri = Uri.parse("https://dummyjson.com/products?limit=$limit&skip=$skip");

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return (jsonResponse["products"] as List)
            .map((item) => Product.fromJson(item))
            .toList();
      } else {
        throw Exception("Failed to load products. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching products: $e");
      throw Exception("Error fetching products");
    }
  }
}
