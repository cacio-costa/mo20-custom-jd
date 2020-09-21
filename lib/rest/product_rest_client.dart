import 'dart:convert';

import 'package:casadocodigoapp/models/book.dart';
import 'package:casadocodigoapp/models/product.dart';
import 'package:casadocodigoapp/rest/book_rest_client.dart';
import 'package:casadocodigoapp/rest/http_client.dart';
import 'package:http/http.dart';

class ProductRestClient {
  static const String _productResourceUrl = baseUrl + '/admin/products';

  // Rest client para trazer as informações do livro relacionado ao produto
  BookRestClient _bookRestClient = BookRestClient();

  Future<List<Product>> findAll() async {
    Response response = await httpClient.get(_productResourceUrl).timeout(Duration(seconds: 15));

    List<Product> productsWithBooks = List();

    List<dynamic> jsonList = jsonDecode(response.body);
    for(dynamic productJson in jsonList) {
      Product product = Product.fromJson(productJson);

      Book book = await _bookRestClient.findById(product.bookId);
      product.book = book;

      productsWithBooks.add(product);
    }

    return productsWithBooks;
  }

  Future<Product> save(Product product) async {
    String productJson = jsonEncode(product.toJson());

    Response saveResponse = await httpClient.post(_productResourceUrl, body: productJson, headers: {
      'Content-Type': 'application/json',
    });

    Map<String, dynamic> savedProductJson = jsonDecode(saveResponse.body);
    return Product.fromJson(savedProductJson);
  }
}
