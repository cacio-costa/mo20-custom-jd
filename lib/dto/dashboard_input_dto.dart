class DashboardInputDto {

  final int bookCount;
  final int authorCount;
  final int productCount;
  final int categoryCount;

  DashboardInputDto(this.bookCount, this.authorCount, this.productCount, this.categoryCount);

  @override
  String toString() {
    return 'DashboardInputDto{bookCount: $bookCount, authorCount: $authorCount, productCount: $productCount, categoryCount: $categoryCount}';
  }

  // Como esse é um DTO que somente representará dados de entrada, ele NÃO TERÁ o método toJson!
  DashboardInputDto.fromJson(Map<String, dynamic> json)
      : bookCount = json['bookCount'],
        authorCount = json['authorCount'],
        productCount = json['productCount'],
        categoryCount = json['categoryCount'];
}