class ProductColor {
  String url;
  String color;
  String image;
  bool active;
  String available;
  String originalImage;

  ProductColor({
    required this.url,
    required this.color,
    required this.image,
    required this.active,
    required this.available,
    required this.originalImage,
  });

  factory ProductColor.fromJson(Map<String, dynamic> json) {
    return ProductColor(
      url: json['url'] ?? "",
      color: json['color'] ?? "",
      image: json['image'] ?? "",
      active: json['active'] ?? false, // Eğer 'active' null ise varsayılan değeri false yap
      available: json['available'] ?? "", // Eğer 'available' null ise varsayılan değeri boş bir string yap
      originalImage: json['originalImage'] ?? "",
    );
  }
}
