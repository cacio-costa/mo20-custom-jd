import 'package:casadocodigoapp/models/category.dart';
import 'package:casadocodigoapp/rest/category_rest_client.dart';
import 'package:flutter/material.dart';

class CategoryForm extends StatelessWidget {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  
  final CategoryRestClient categoryRestClient = CategoryRestClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                style: TextStyle(fontSize: 24.0),
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                controller: descriptionController,
                style: TextStyle(fontSize: 24.0),
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Create'),
                    onPressed: () {
                      debugPrint('*** CategoryForm -> Create ***');
                      _saveCategory(context);
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

  void _saveCategory(BuildContext context) async {
    String title = titleController.text;
    String description = descriptionController.text;

    if (_isFormValid(title, description)) {
      Category newCategory = Category(title, description);

      Category savedCategory = await categoryRestClient.save(newCategory);
      if (savedCategory != null) {
        debugPrint('*** CategoryForm -> Create -> category saved ***');
        Navigator.pop(context);
      } else {
        debugPrint('*** CategoryForm -> Create -> error on save category ***');
      }
    }
  }

  bool _isFormValid(String title, String description) {
    return title != null
        && title.trim().isNotEmpty
        && description != null
        && title.trim().isNotEmpty;
  }

}