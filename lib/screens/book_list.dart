import 'package:casadocodigoapp/components/centered_message.dart';
import 'package:casadocodigoapp/components/loading.dart';
import 'package:casadocodigoapp/models/book.dart';
import 'package:casadocodigoapp/rest/book_rest_client.dart';
import 'package:casadocodigoapp/screens/book_form.dart';
import 'package:flutter/material.dart';

class BookList extends StatefulWidget {
  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  // Cliente para recuperar os autores
  final BookRestClient bookRestClient = BookRestClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books'),
      ),
      body: FutureBuilder<List<Book>>(
        future: bookRestClient.findAll(),
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
                return CenteredMessage('Error on fetching books', icon: Icons.error);
              }

              List<Book> books = snapshot.data;
              if (books != null && books.isNotEmpty) {
                return _showList(books);
              }

              return CenteredMessage('No books found!', icon: Icons.warning);
              break;
          }

          return CenteredMessage('Unknown error!', icon: Icons.error);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showBookForm(context),
      ),
    );
  }

  void _showBookForm(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => BookForm()))
        .then((newBook) {
          // Só busca nova listagem na API se um novo autor foi salvo
          if (newBook != null) {
            setState(() {}); // Rebuild da tela após salvar autor
          }
        });
  }

  ListView _showList(List<Book> books) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        return _BookItem(books[index]);
      },
    );
  }
}

class _BookItem extends StatelessWidget {
  final Book book;

  _BookItem(
    this.book,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          book.title,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '\n${book.description}',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
    ;
  }
}
