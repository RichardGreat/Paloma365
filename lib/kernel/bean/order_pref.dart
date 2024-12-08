class OrderPref {
  static const ORDER_STATUS_COMPLETE = "C";
  static const ORDER_STATUS_NEW = "N";
  static const ORDER_STATUS_IN_PROGRESS = "I";
}

class OrderSaveModel {
  final int orderId;
  final String orderDate;
  final int seatId;
  final String status;
  final List<OrderProductSaveModel> products;

  OrderSaveModel({
    required this.orderId,
    required this.orderDate,
    required this.seatId,
    required this.status,
    this.products = const [],
  });
}

class OrderProductSaveModel {
  final int orderId;
  final int productId;
  final int quantity;
  final double price;

  OrderProductSaveModel({
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
  });
}
