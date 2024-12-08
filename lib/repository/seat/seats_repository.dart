import 'package:paloma365/kernel/bean/order_pref.dart';
import 'package:paloma365/kernel/bean/seat.dart';
import 'package:paloma365/kernel/tables/order_products.dart';
import 'package:paloma365/kernel/tables/orders.dart';
import 'package:paloma365/kernel/tables/seats.dart';
import 'package:sqflite/sqflite.dart';

class SeatsRepository {
  final Database db;

  SeatsRepository(this.db);

  Future<List<Seat>> getSeats() async {
    // Join with orders to get latest order information
    final result = await db.rawQuery('''
      SELECT 
        s.${RSeats.C_SEAT_ID},
        s.${RSeats.C_SEAT_NUMBER},
        o.order_date as last_order_time,
        o.order_id,
        (
          SELECT SUM(op.${COrderProducts.C_PRICE} * op.${COrderProducts.C_QUANTITY})
          FROM ${COrderProducts.TABLE_NAME} op
          WHERE op.${COrderProducts.C_ORDER_ID} = o.${COrders.C_ORDER_ID}
        ) as total_amount
      FROM ${RSeats.TABLE_NAME} s
      LEFT JOIN (
        SELECT r.${COrders.C_SEAT_ID}, r.${COrders.C_ORDER_DATE}, r.${COrders.C_ORDER_ID}
        FROM ${COrders.TABLE_NAME} r
        WHERE r.${COrders.C_STATUS} != '${OrderPref.ORDER_STATUS_COMPLETE}'
      ) o ON s.${RSeats.C_SEAT_ID} = o.${COrders.C_SEAT_ID}
      ORDER BY s.${RSeats.C_SEAT_NUMBER}
    ''');

    return result.map((data) => Seat.fromData(data)).toList();
  }
}
