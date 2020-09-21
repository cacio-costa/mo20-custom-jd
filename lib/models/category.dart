class Category {
  final int id;
  final String title;
  final String description;

  Category(this.title, this.description, { this.id });

  @override
  String toString() {
    return 'Category{id: $id, title: $title, description: $description}';
  }

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'];

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'title': title,
        'description': description
      };
}