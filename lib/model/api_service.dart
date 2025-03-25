import 'dart:convert';
import 'package:cartify_app/model/items.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Product>?> fetchProducts() async {
    var client = http.Client();
    var uri = Uri.parse("https://dummyjson.com/products");

    try {
      var response = await client.get(uri);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body); // Convert String to JSON
        List<Product> products = (jsonResponse["products"] as List)
            .map((item) => Product.fromJson(item))
            .toList();
        return products;
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching products: $e");
      return null;
    } finally {
      client.close();
    }
  }
}
