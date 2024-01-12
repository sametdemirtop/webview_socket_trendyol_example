import 'package:bravo_shopgo_example/models/product/product_data_model.dart';

class TrendyolProduct {
  int wpId;
  int backgroundTask;
  String status;
  dynamic error;
  int productId;
  TrendyolProductData data;

  TrendyolProduct({
    required this.wpId,
    required this.backgroundTask,
    required this.status,
    required this.error,
    required this.productId,
    required this.data,
  });

  factory TrendyolProduct.fromJson(Map<String, dynamic> json) {
    return TrendyolProduct(
      wpId: json['wp_id'],
      backgroundTask: json['background_task'],
      status: json['status'],
      error: json['error'],
      productId: json['product_id'],
      data: TrendyolProductData.fromJson(json['data']),
    );
  }
}