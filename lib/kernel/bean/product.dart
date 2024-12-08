class Product {
  final int id;
  final String name;
  final double price;
  final int productTypeId;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.productTypeId,
    this.quantity = 0,
  });
}
