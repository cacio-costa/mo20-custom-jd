class Book {
  final int id;
  final int pages;
  final int authorId;
  final int categoryId;

  final String title;
  final String description;
  final String releaseDate;

  Book(this.title, this.description, this.pages, this.releaseDate, this.authorId, this.categoryId, {this.id});


  @override
  String toString() {
    return 'Book{id: $id, pages: $pages, authorId: $authorId, categoryId: $categoryId, title: $title, description: $description, releaseDate: $releaseDate}';
  }

  Book.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        pages = json['pages'],
        title = json['title'],
        authorId = json['authorId'],
        categoryId = json['categoryId'],
        description = json['description'],
        releaseDate = json['description'];

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'pages': pages,
        'title': title,
        'authorId': authorId,
        'categoryId': categoryId,
        'description': description,
        'releaseDate': releaseDate
      };
}