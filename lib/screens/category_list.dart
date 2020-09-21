import 'package:casadocodigoapp/components/centered_message.dart';
import 'package:casadocodigoapp/components/loading.dart';
import 'package:casadocodigoapp/models/category.dart';
import 'package:casadocodigoapp/rest/category_rest_client.dart';
import 'package:casadocodigoapp/screens/category_form.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  // Cliente para recuperar as categorias
  final CategoryRestClient categoryRestClient = CategoryRestClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: FutureBuilder<List<Category>>(
        future: categoryRestClient.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Loading();
              break;
            case ConnectionState.active:
              // TODO: Handle this case.
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return CenteredMessage('Error on fetching categories', icon: Icons.error);
              }

              List<Category> categories = snapshot.data;
              if (categories != null && categories.isNotEmpty) {
                return _showList(categories);
              }

              return CenteredMessage('No categories found!', icon: Icons.warning);
              break;
          }

          return CenteredMessage('Unknown error!', icon: Icons.error);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showCategoryForm(context),
      ),
    );
  }

  void _showCategoryForm(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => CategoryForm()))
        .then((newCategory) {
          // Só busca nova listagem na API se uma nova categoria foi salva
          if (newCategory != null) {
            setState(() {});
          }
        }); // Rebuild da tela após salvar categoria
  }

  ListView _showList(List<Category> categories) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return _CategoryItem(categories[index]);
      },
    );
  }
}

class _CategoryItem extends StatelessWidget {
  // Categoria que é exibida no ListTile
  final Category category;

  _CategoryItem(
    this.category,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          category.title,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          category.description,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
