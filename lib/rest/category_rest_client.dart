import 'dart:convert';

import 'package:casadocodigoapp/models/category.dart';
import 'package:casadocodigoapp/rest/http_client.dart';
import 'package:http/http.dart';

class CategoryRestClient {
  static const String _categoryResourceUrl = baseUrl + '/admin/categories';

  Future<List<Category>> findAll() async {
    Response response = await httpClient.get(_categoryResourceUrl).timeout(Duration(seconds: 15));

    List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((dynamic json) => Category.fromJson(json))
        .toList();
  }

  Future<Category> save(Category category) async {
    String categoryJson = jsonEncode(category.toJson());

    Response saveResponse = await httpClient.post(_categoryResourceUrl, body: categoryJson, headers: {
      'Content-Type': 'application/json',
    });

    Map<String, dynamic> savedCategoryJson = jsonDecode(saveResponse.body);
    return Category.fromJson(savedCategoryJson);
  }
}
