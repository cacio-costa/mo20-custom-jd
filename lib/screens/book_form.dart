import 'package:casadocodigoapp/models/book.dart';
import 'package:casadocodigoapp/rest/book_rest_client.dart';
import 'package:flutter/material.dart';

class BookForm extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController releaseDateController = TextEditingController();
  final TextEditingController pagesController = TextEditingController();
  final TextEditingController autorIdController = TextEditingController();
  final TextEditingController categoryIdController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final BookRestClient bookRestClient = BookRestClient();

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
                controller: titleController,
                style: TextStyle(fontSize: 24.0),
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                controller: releaseDateController,
                style: TextStyle(fontSize: 24.0),
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  labelText: 'Release date',
                ),
              ),
              TextField(
                controller: pagesController,
                style: TextStyle(fontSize: 24.0),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Pages',
                ),
              ),
              TextField(
                controller: autorIdController,
                style: TextStyle(fontSize: 24.0),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Author ID',
                ),
              ),
              TextField(
                controller: categoryIdController,
                style: TextStyle(fontSize: 24.0),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Category ID',
                ),
              ),
              TextField(
                controller: descriptionController,
                minLines: 2,
                maxLines: 3,
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
                      debugPrint('*** BookForm -> Create ***');
                      _saveBook(context);
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

  void _saveBook(BuildContext context) async {
    String title = titleController.text;
    String releaseDate = releaseDateController.text;
    int pages = int.tryParse(pagesController.text);
    int authorId = int.tryParse(autorIdController.text);
    int categoryId = int.tryParse(categoryIdController.text);
    String description = descriptionController.text;

    if (_isFormValid(title, authorId, categoryId)) {
      Book newBook = Book(title, description, pages, releaseDate, authorId, categoryId);

      Book savedBook = await bookRestClient.save(newBook);
      if (savedBook != null) {
        debugPrint('*** BookForm -> Create -> book saved ***');
        Navigator.pop(context, savedBook);
      } else {
        debugPrint('*** BookForm -> Create -> error on save book ***');
      }
    }
  }

  bool _isFormValid(String title, int authorId, int categoryId) {
    return title != null
        && title.trim().isNotEmpty
        && authorId != null
        && categoryId != null;
  }
}
