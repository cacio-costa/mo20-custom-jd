class Author {
  final int id;

  final String name;
  final String email;
  final String avatarUrl;
  final String description;

  Author(this.name, this.email, this.avatarUrl, this.description, {this.id});

  @override
  String toString() {
    return 'Author{id: $id, name: $name, email: $email, avatarUrl: $avatarUrl, description: $description}';
  }

  Author.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        avatarUrl = json['avatarUrl'],
        description = json['description'];

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'email': email,
        'avatarUrl': avatarUrl,
        'description': description
      };
}