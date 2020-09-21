import 'package:casadocodigoapp/models/author.dart';
import 'package:casadocodigoapp/models/category.dart';
import 'package:casadocodigoapp/rest/author_rest_client.dart';
import 'package:casadocodigoapp/rest/category_rest_client.dart';
import 'package:flutter/material.dart';

class AuthorForm extends StatelessWidget {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController avatarController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  
  final AuthorRestClient authorRestClient = AuthorRestClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New author'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                style: TextStyle(fontSize: 24.0),
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextField(
                controller: emailController,
                style: TextStyle(fontSize: 24.0),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: avatarController,
                style: TextStyle(fontSize: 24.0),
                decoration: InputDecoration(
                  labelText: 'Avatar URL',
                ),
              ),
              TextField(
                controller: descriptionController,
                style: TextStyle(fontSize: 24.0),
                minLines: 2,
                maxLines: 3,
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
                      debugPrint('*** AuthorForm -> Create ***');
                      _saveAuthor(context);
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

  void _saveAuthor(BuildContext context) async {
    String name = nameController.text;
    String email = emailController.text;
    String avatarUrl = avatarController.text;
    String description = descriptionController.text;

    if (_isFormValid(name, email, description)) {
      Author newAuthor = Author(name, email, avatarUrl, description);

      Author savedAuthor = await authorRestClient.save(newAuthor);
      if (savedAuthor != null) {
        debugPrint('*** AuthorForm -> Create -> author saved ***');
        Navigator.pop(context, savedAuthor);
      } else {
        debugPrint('*** AuthorForm -> Create -> error on save author ***');
      }
    }
  }

  bool _isFormValid(String name, String email, String description) {
    return name != null
        && name.trim().isNotEmpty
        && email != null
        && email.trim().isNotEmpty
        && description != null
        && description.trim().isNotEmpty;
  }

}