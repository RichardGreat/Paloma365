import 'package:paloma365/kernel/bean/order_history.dart';
import 'package:paloma365/kernel/tables/order_products.dart';
import 'package:paloma365/kernel/tables/orders.dart';
import 'package:sqflite/sqflite.dart';

class HistoryRepository {
  final Database db;

  HistoryRepository(this.db);

  // Get all orders history with optional filters
  Future<List<OrderHistory>> getOrdersHistory() async {
    String query = '''
      SELECT 
        o.${COrders.C_ORDER_ID},
        o.${COrders.C_SEAT_ID},
        o.${COrders.C_ORDER_DATE},
        o.${COrders.C_STATUS},
        COALESCE(SUM(op.${COrderProducts.C_PRICE} * op.${COrderProducts.C_QUANTITY}), 0) as total_amount
       FROM ${COrders.TABLE_NAME} o
  LEFT JOIN ${COrderProducts.TABLE_NAME} op ON o.${COrders.C_ORDER_ID} = op.${COrderProducts.C_ORDER_ID}
   GROUP BY o.${COrders.C_ORDER_ID} ORDER BY o.${COrders.C_ORDER_DATE} DESC
    ''';
    final List<OrderHistory> history = [];
    final results = await db.rawQuery(query);
    final orders = results.map((map) => OrderHistory.fromMap(map)).toList();

    for (var order in orders) {
      final items = await _getOrderItems(order.orderId);
      history.add(
        OrderHistory(
          orderId: order.orderId,
          seatNumber: order.seatNumber,
          orderDate: order.orderDate,
          status: order.status,
          total: order.total,
          items: items,
        ),
      );
    }

    return history;
  }

  // Get items for specific order
  Future<List<OrderHistoryItem>> _getOrderItems(int orderId) async {
    final query = '''
      SELECT 
        p.name as product_name,
        op.quantity,
        op.price
      FROM c_order_products op
      JOIN r_products p ON op.product_id = p.product_id
      WHERE op.order_id = $orderId
    ''';

    final results = await db.rawQuery(query);
    return results.map((map) => OrderHistoryItem.fromMap(map)).toList();
  }
}
