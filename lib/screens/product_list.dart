import 'package:casadocodigoapp/components/centered_message.dart';
import 'package:casadocodigoapp/components/loading.dart';
import 'package:casadocodigoapp/models/product.dart';
import 'package:casadocodigoapp/rest/product_rest_client.dart';
import 'package:casadocodigoapp/screens/product_form.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  // Cliente para recuperar os autores
  final ProductRestClient productRestClient = ProductRestClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: FutureBuilder<List<Product>>(
        future: productRestClient.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Loading();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return CenteredMessage('Error on fetching products', icon: Icons.error);
              }

              List<Product> products = snapshot.data;
              if (products != null && products.isNotEmpty) {
                return _showList(products);
              }

              return CenteredMessage('No products found!', icon: Icons.warning);
              break;
          }

          return CenteredMessage('Unknown error!', icon: Icons.error);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showProductForm(context),
      ),
    );
  }

  void _showProductForm(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => ProductForm()))
        .then((newProduct) {
          // Só busca nova listagem na API se um novo produto foi salvo
          if (newProduct != null) {
            setState(() {}); // Rebuild da tela após salvar produto
          }
        });
  }

  ListView _showList(List<Product> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _ProductItem(products[index]);
      },
    );
  }
}

class _ProductItem extends StatelessWidget {
  final Product product;

  _ProductItem(
    this.product,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          product.book.title, // exibe o título do Book relacionado ao Product
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${product.kind}: ${product.price}',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
