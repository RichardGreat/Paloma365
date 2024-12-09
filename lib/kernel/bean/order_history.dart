class OrderHistory {
  final int orderId;
  final int seatNumber;
  final String orderDate;
  final String status;
  final double total;
  final List<OrderHistoryItem> items;

  const OrderHistory({
    required this.orderId,
    required this.seatNumber,
    required this.orderDate,
    required this.status,
    required double total,
    required this.items,
  }) : total = (total * 0.15) + total;

  factory OrderHistory.fromMap(Map<String, dynamic> map) {
    return OrderHistory(
      orderId: map['order_id'] as int,
      seatNumber: map['seat_id'] as int,
      orderDate: map['order_date'] as String,
      status: map['status'] as String,
      total: map['total_amount'] as double,
      items: [], // Items are loaded separately
    );
  }
}

class OrderHistoryItem {
  final String productName;
  final int quantity;
  final double price;
  final double total;

  const OrderHistoryItem({
    required this.productName,
    required this.quantity,
    required this.price,
    required this.total,
  });

  factory OrderHistoryItem.fromMap(Map<String, dynamic> map) {
    return OrderHistoryItem(
      productName: map['product_name'] as String,
      quantity: map['quantity'] as int,
      price: map['price'] as double,
      total: (map['price'] as double) * (map['quantity'] as int),
    );
  }
}
