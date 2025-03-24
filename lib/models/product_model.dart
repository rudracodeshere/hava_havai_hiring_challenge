class Product {
  final int id;
  final String name;
  final String brand;
  final double originalPrice;
  final double discountPercentage;
  final String thumbnailUrl;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.originalPrice,
    required this.discountPercentage,
    required this.thumbnailUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['title'] ?? 'Unknown Product',
      brand: json ['brand'] ?? 'Unknown Brand',
      originalPrice: (json['price'] as num?)?.toDouble() ?? 0.0,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0.0, 
      thumbnailUrl: json['thumbnail'],
    );
  }

  double get discountedPrice =>
      originalPrice * (1 - discountPercentage / 100);

  double get discountPercent => discountPercentage.roundToDouble();
}