import 'package:casadocodigoapp/screens/dashboard.dart';
import 'package:casadocodigoapp/screens/product_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CasaDoCodigoApp());
}

class CasaDoCodigoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard(),
    );
  }
}