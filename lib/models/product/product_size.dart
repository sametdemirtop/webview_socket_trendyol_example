class ProductSize {
  String size;
  double price;
  String available;

  ProductSize({
    required this.size,
    required this.price,
    required this.available,
  });

  factory ProductSize.fromJson(Map<String, dynamic> json) {
    return ProductSize(
      size: json['size'],
      price: json['price'].toDouble(),
      available: json['available'],
    );
  }
}