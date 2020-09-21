import 'package:casadocodigoapp/models/book.dart';

class Product {
  final int id;
  final int bookId;

  final String kind;
  final double price;

  // Relacionamento para exibir as informações do livro na tela de listagem
  Book book;

  Product(this.bookId, this.price, this.kind, {this.id});

  @override
  String toString() {
    return 'Product{id: $id, bookId: $bookId, kind: $kind, price: $price, book: $book}';
  }

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        kind = json['kind'],
        price = json['price'],
        bookId = json['bookId'];

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'kind': kind,
        'price': price,
        'bookId': bookId
      };
}