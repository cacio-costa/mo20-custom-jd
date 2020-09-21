import 'package:casadocodigoapp/rest/category_rest_client.dart';
import 'package:casadocodigoapp/rest/http_client.dart';
import 'package:casadocodigoapp/screens/category_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CasaDoCodigoApp());
}

class CasaDoCodigoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CategoryList(),
    );
  }
}