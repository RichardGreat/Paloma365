class Order {
  final int id;
  final int seatId;
  final String orderDate;
  final double total;
  final String status;

  const Order({
    required this.id,
    required this.seatId,
    required this.orderDate,
    required this.total,
    required this.status,
  });
}
