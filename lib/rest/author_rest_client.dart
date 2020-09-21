import 'dart:convert';

import 'package:casadocodigoapp/models/author.dart';
import 'package:casadocodigoapp/rest/http_client.dart';
import 'package:http/http.dart';

class AuthorRestClient {
  static const String _authorResourceUrl = baseUrl + '/admin/authors';

  Future<List<Author>> findAll() async {
    Response response = await httpClient.get(_authorResourceUrl).timeout(Duration(seconds: 15));

    List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((dynamic json) => Author.fromJson(json))
        .toList();
  }

  Future<Author> save(Author author) async {
    String authorJson = jsonEncode(author.toJson());

    Response saveResponse = await httpClient.post(_authorResourceUrl, body: authorJson, headers: {
      'Content-Type': 'application/json',
    });

    Map<String, dynamic> savedAuthorJson = jsonDecode(saveResponse.body);
    return Author.fromJson(savedAuthorJson);
  }
}
