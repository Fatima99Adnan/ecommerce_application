class Product {
  int? id;
  String? title;
  String? description;
  String? category;
  double? price;
  String? thumbnail;

  Product(
      {this.id,
      this.title,
      this.description,
      this.category,
      this.price,
      this.thumbnail});

  Product.fromJson(Map<String, dynamic> item) {
    id = item['id'];
    title = item['title'];
    description = item['description'];
    category = item['category'];
    price = item['price'];
    thumbnail = item['thumbnail'];
  }
}
