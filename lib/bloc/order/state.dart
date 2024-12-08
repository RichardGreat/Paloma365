// States
import 'package:paloma365/kernel/bean/order_pref.dart';
import 'package:paloma365/kernel/bean/product.dart';
import 'package:paloma365/kernel/bean/product_type.dart';

abstract class OrderState {}

class OrderSaved extends OrderState {}
class OrderInitial extends OrderState {}

class OrderLoadSuccess extends OrderState {
  final List<Product> products;
  final List<Product> filteredProducts;
  final int? selectedTypeId;
  final double serviceFee;
  final double totalAmount;
  final int totalQuantity;
  final String orderStatus;
  final List<ProductType> productTypes;

  bool isNew() => orderStatus == OrderPref.ORDER_STATUS_NEW;

  OrderLoadSuccess({
    required this.products,
    required this.filteredProducts,
    required this.selectedTypeId,
    required this.orderStatus,
    required double totalAmount,
    required this.totalQuantity,
    required this.productTypes,
  })  : serviceFee = totalAmount * 0.15,
        totalAmount = totalAmount + (totalAmount * 0.15);
}
