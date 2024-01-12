import 'package:bravo_shopgo_example/models/product/product_color_model.dart';
import 'package:bravo_shopgo_example/models/product/product_size.dart';

class TrendyolProductData {
  String website;
  String brandLogo;
  String productUrl;
  String productName;
  List<ProductColor> productColors;
  List<ProductSize> productSizes;
  List<String> productCategory;

  TrendyolProductData({
    required this.website,
    required this.brandLogo,
    required this.productUrl,
    required this.productName,
    required this.productColors,
    required this.productSizes,
    required this.productCategory,
  });

  factory TrendyolProductData.fromJson(Map<String, dynamic> json) {
    return TrendyolProductData(
      website: json['website'] ?? "",
      brandLogo: json['brandLogo'] ?? "",
      productUrl: json['productUrl'] ?? "",
      productName: json['productName'] ?? "",
      productColors: List<ProductColor>.from(json['productColors'].map((x) => ProductColor.fromJson(x))) ,
      productSizes: List<ProductSize>.from(json['productSizes'].map((x) => ProductSize.fromJson(x))),
      productCategory: List<String>.from(json['productCategory'].map((x) => x)),
    );
  }
}