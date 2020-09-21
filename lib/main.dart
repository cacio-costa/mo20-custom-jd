import 'package:casadocodigoapp/screens/book_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CasaDoCodigoApp());
}

class CasaDoCodigoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BookList(),
    );
  }
}