import 'package:casadocodigoapp/models/product.dart';
import 'package:casadocodigoapp/rest/product_rest_client.dart';
import 'package:flutter/material.dart';

class ProductForm extends StatelessWidget {
  final TextEditingController bookIdController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController kindController = TextEditingController();

  final ProductRestClient productRestClient = ProductRestClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: bookIdController,
                style: TextStyle(fontSize: 24.0),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Book ID',
                ),
              ),
              TextField(
                controller: priceController,
                style: TextStyle(fontSize: 24.0),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
              ),
              TextField(
                controller: kindController,
                style: TextStyle(fontSize: 24.0),
                decoration: InputDecoration(
                  labelText: 'Kind',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Create'),
                    onPressed: () {
                      debugPrint('*** ProductForm -> Create ***');
                      _saveProduct(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveProduct(BuildContext context) async {
    int bookId = int.tryParse(bookIdController.text);
    double price = double.tryParse(priceController.text);

    String kind = kindController.text;

    if (_isFormValid(bookId, price, kind)) {
      Product newProduct = Product(bookId, price, kind);

      Product savedProduct = await productRestClient.save(newProduct);
      if (savedProduct != null) {
        debugPrint('*** ProductForm -> Create -> product saved ***');
        Navigator.pop(context, savedProduct);
      } else {
        debugPrint('*** ProductForm -> Create -> error on save product ***');
      }
    }
  }

  bool _isFormValid(int bookId, double price, String kind) {
    if (bookId == null || price == null || kind == null || kind.trim().isEmpty) {
      return false; // um dos campos não foi preenchido
    }

    // Só aceitas as opções válidas para o tipo de produto
    return kind == 'EBOOK'
        || kind == 'PRINTED'
        || kind == 'COMBO';
  }
}
