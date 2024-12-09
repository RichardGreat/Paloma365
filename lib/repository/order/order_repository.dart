import 'package:paloma365/kernel/bean/order.dart';
import 'package:paloma365/kernel/bean/order_api.dart';
import 'package:paloma365/kernel/bean/order_pref.dart';
import 'package:paloma365/kernel/bean/product.dart';
import 'package:paloma365/kernel/bean/product_type.dart';
import 'package:paloma365/kernel/tables/order_products.dart';
import 'package:paloma365/kernel/tables/orders.dart';
import 'package:paloma365/kernel/tables/product_type_binds.dart';
import 'package:paloma365/kernel/tables/products.dart';
import 'package:paloma365/kernel/util.dart';
import 'package:sqflite/sqflite.dart';

class OrderRepository {
  final Database db;

  OrderRepository(this.db);

  // Load product types
  Future<List<ProductType>> getProductTypes() async {
    final result = await db.query('r_product_types');
    return result
        .map((map) => ProductType(
              id: map['product_type_id'] as int,
              name: map['name'] as String,
            ))
        .toList();
  }

  // Load products
  Future<List<Product>> getProducts(int orderId) async {
    final sql = """
    SELECT p.*, 
           (SELECT pt.${RProductTypeBinds.C_PRODUCT_TYPE_ID}
              FROM ${RProductTypeBinds.TABLE_NAME} pt
             WHERE pt.${RProductTypeBinds.C_PRODUCT_ID} = p.${RProducts.C_PRODUCT_ID}) as product_type_id,
           (SELECT op.${COrderProducts.C_QUANTITY}
              FROM ${COrderProducts.TABLE_NAME} op
             WHERE op.${COrderProducts.C_ORDER_ID} = $orderId 
               AND op.${COrderProducts.C_PRODUCT_ID} = p.${RProducts.C_PRODUCT_ID}) as quantity
      FROM ${RProducts.TABLE_NAME} p
    """;
    final result = await db.rawQuery(sql);
    return result
        .map((map) => Product(
              id: map['product_id'] as int,
              name: map['name'] as String,
              price: map['price'] as double,
              productTypeId: map['product_type_id'] as int,
              quantity: map["quantity"] != null ? nvlTryInt(map["quantity"]!)! : 0,
            ))
        .toList();
  }

  // Get existing order or create new one
  Future<Order> getOrCreateOrder(int seatId) async {
    // Try to find existing incomplete order for this seat
    final sql = """
       SELECT o.*, 
              (SELECT SUM(p.${COrderProducts.C_PRICE} * p.${COrderProducts.C_QUANTITY}) as total_amount 
                 FROM ${COrderProducts.TABLE_NAME} p
                WHERE p.${COrderProducts.C_ORDER_ID} = o.${COrders.C_ORDER_ID}) as total_amount
         FROM ${COrders.TABLE_NAME} o
        WHERE o.${COrders.C_SEAT_ID} = $seatId
          AND o.${COrders.C_STATUS} != '${OrderPref.ORDER_STATUS_COMPLETE}'
    """;

    final existingOrders = await db.rawQuery(sql);

    if (existingOrders.isNotEmpty) {
      // Found existing order, load its items
      final orderId = existingOrders.first[COrders.C_ORDER_ID] as int;

      return Order(
        id: orderId,
        seatId: seatId,
        orderDate: existingOrders.first[COrders.C_ORDER_DATE] as String,
        status: existingOrders.first[COrders.C_STATUS] as String,
        total: nvlTryNum(existingOrders.first["total_amount"]!)?.toDouble() ?? 0,
      );
    }

    // Create new order
    final newOrderId = DateTime.now().millisecondsSinceEpoch;
    return Order(
      id: newOrderId,
      seatId: seatId,
      orderDate: DateTime.now().toIso8601String(),
      status: OrderPref.ORDER_STATUS_NEW,
      total: 0,
    );
  }

  Future<void> saveOrder(OrderSaveModel order) async {
    return db.transaction((tx) async {
      final Batch batch = tx.batch();
      await OrderApi.saveOrder(batch, order);
      await batch.commit(noResult: false);
    });
  }
}
