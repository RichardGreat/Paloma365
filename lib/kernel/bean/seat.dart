import 'package:paloma365/kernel/tables/orders.dart';
import 'package:paloma365/kernel/tables/seats.dart';
import 'package:paloma365/kernel/util.dart';

class Seat {
  final int id;
  final int number;
  final String? lastOrderTime;
  final double? totalAmount;
  final int? orderId;

  const Seat({
    required this.id,
    required this.number,
    this.lastOrderTime,
    this.totalAmount,
    this.orderId,
  });

  bool get isOccupied => orderId != null;

  factory Seat.fromData(Map<String, dynamic> data) {
    return Seat(
      id: nvlTryInt(data[RSeats.C_SEAT_ID])!,
      number: nvlTryInt(data[RSeats.C_SEAT_NUMBER])!,
      lastOrderTime: nvlString(data[COrders.C_ORDER_DATE], ""),
      orderId: data[COrders.C_ORDER_ID] != null ? nvlTryInt(data[COrders.C_ORDER_ID]) : null,
      totalAmount: nvlTryNum(data["total_amount"] ?? 0)?.toDouble(),
    );
  }
}
