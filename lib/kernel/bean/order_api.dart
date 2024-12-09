import 'package:paloma365/kernel/bean/order_pref.dart';
import 'package:paloma365/kernel/tables/order_products.dart';
import 'package:paloma365/kernel/tables/orders.dart';
import 'package:sqflite/sqflite.dart';

class OrderApi {
  static Future<void> saveOrder(Batch batch, OrderSaveModel order) async {
    deleteOldOrderData(batch, order.orderId);
    await Z_COrders.saveOne(
      batch,
      orderId: order.orderId,
      orderDate: order.orderDate,
      seatId: order.seatId,
      status: order.status,
    );
    await _saveProducts(batch, order.orderId, order.products);
  }

  static Future<void> _saveProducts(
      Batch batch, int orderId, List<OrderProductSaveModel> products) async {
    for (var product in products) {
      await Z_COrderProducts.saveOne(
        batch,
        orderId: orderId,
        productId: product.productId,
        price: product.price,
        quantity: product.quantity,
      );
    }
  }

  static void deleteOldOrderData(Batch batch, int orderId) {
    batch.delete(
      COrderProducts.TABLE_NAME,
      where: "${COrderProducts.C_ORDER_ID} = ?",
      whereArgs: [orderId],
    );
    batch.delete(COrders.TABLE_NAME, where: "${COrders.C_ORDER_ID} = ?", whereArgs: [orderId]);
  }
}
