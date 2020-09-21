import 'dart:convert';

import 'package:casadocodigoapp/models/book.dart';
import 'package:casadocodigoapp/rest/http_client.dart';
import 'package:http/http.dart';

class BookRestClient {
  static const String _bookResourceUrl = baseUrl + '/admin/books';

  Future<List<Book>> findAll() async {
    Response response = await httpClient.get(_bookResourceUrl).timeout(Duration(seconds: 15));

    List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((dynamic json) => Book.fromJson(json))
        .toList();
  }

  Future<Book> findById(int bookId) async {
    Response response = await httpClient.get('$_bookResourceUrl/$bookId'); // adiciona ID na url para fazer a busca

    Map<String, dynamic> bookJson = jsonDecode(response.body);
    return Book.fromJson(bookJson);
  }

  Future<Book> save(Book book) async {
    String bookJson = jsonEncode(book.toJson());

    Response saveResponse = await httpClient.post(_bookResourceUrl, body: bookJson, headers: {
      'Content-Type': 'application/json',
    });

    Map<String, dynamic> savedBookJson = jsonDecode(saveResponse.body);
    return Book.fromJson(savedBookJson);
  }


}
