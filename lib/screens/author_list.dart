import 'package:casadocodigoapp/components/centered_message.dart';
import 'package:casadocodigoapp/components/loading.dart';
import 'package:casadocodigoapp/models/author.dart';
import 'package:casadocodigoapp/rest/author_rest_client.dart';
import 'package:casadocodigoapp/screens/author_form.dart';
import 'package:flutter/material.dart';

class AuthorList extends StatefulWidget {
  @override
  _AuthorListState createState() => _AuthorListState();
}

class _AuthorListState extends State<AuthorList> {
  // Cliente para recuperar os autores
  final AuthorRestClient authorRestClient = AuthorRestClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authors'),
      ),
      body: FutureBuilder<List<Author>>(
        future: authorRestClient.findAll(),
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
                return CenteredMessage('Error on fetching authors', icon: Icons.error);
              }

              List<Author> authors = snapshot.data;
              if (authors != null && authors.isNotEmpty) {
                return _showList(authors);
              }

              return CenteredMessage('No authors found!', icon: Icons.warning);
              break;
          }

          return CenteredMessage('Unknown error!', icon: Icons.error);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAuthorForm(context),
      ),
    );
  }

  void _showAuthorForm(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => AuthorForm()))
        .then((newAuthor) {
          // Só busca nova listagem na API se um novo autor foi salvo
          if (newAuthor != null) {
            setState(() {}); // Rebuild da tela após salvar autor
          }
        });
  }

  ListView _showList(List<Author> authors) {
    return ListView.builder(
      itemCount: authors.length,
      itemBuilder: (context, index) {
        return _AuthorItem(authors[index]);
      },
    );
  }
}

class _AuthorItem extends StatelessWidget {
  final Author author;

  _AuthorItem(
    this.author,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          author.name,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          author.email,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
