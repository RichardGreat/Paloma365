import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paloma365/bloc/order/event.dart';
import 'package:paloma365/bloc/order/state.dart';
import 'package:paloma365/kernel/bean/order.dart';
import 'package:paloma365/kernel/bean/order_pref.dart';
import 'package:paloma365/kernel/bean/product.dart';
import 'package:paloma365/kernel/bean/product_type.dart';
import 'package:paloma365/repository/order/order_repository.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  late List<ProductType> _productTypes;
  late List<Product> _allProducts;
  late Order _order;
  final OrderRepository repository;

  OrderBloc({required this.repository}) : super(OrderInitial()) {
    on<SaveOrder>((event, emit) {
      saveOrder();
    });

    on<CompleteOrder>((event, emit) {
      completeOrder();
    });

    on<LoadProducts>((event, emit) {
      loadProducts(event.orderId, event.seatId);
    });

    on<FilterProductsByType>((event, emit) {
      _onSuccess(productTypeId: event.typeId);
    });

    on<SearchProducts>((event, emit) {
      if (state is OrderLoadSuccess) {
        final currentState = state as OrderLoadSuccess;
        _onSuccess(productTypeId: currentState.selectedTypeId, searchQuery: event.query);
      }
    });

    on<UpdateProductQuantity>((event, emit) {
      final product = _allProducts.firstWhere((p) => p.id == event.productId);
      product.quantity = event.quantity;
      if (state is OrderLoadSuccess) {
        final currentState = state as OrderLoadSuccess;
        _onSuccess(productTypeId: currentState.selectedTypeId);
      }
    });
  }

  Future<void> loadProducts(int? orderId, int seatId) async {
    final Order order = await repository.getOrCreateOrder(seatId);
    final List<Product> products = await repository.getProducts(order.id);
    final List<ProductType> productTypes = await repository.getProductTypes();

    _order = order;
    _allProducts = products;
    _productTypes = productTypes;

    _onSuccess();
  }

  Future<void> saveOrder() async {
    final List<Product> orderProducts = _allProducts.where((e) => e.quantity > 0).toList();
    if (orderProducts.isEmpty) return;

    final OrderSaveModel order = OrderSaveModel(
        orderId: _order.id,
        orderDate: _order.orderDate,
        seatId: _order.seatId,
        status: OrderPref.ORDER_STATUS_IN_PROGRESS,
        products: orderProducts
            .map(
              (e) => OrderProductSaveModel(
                orderId: _order.id,
                productId: e.id,
                quantity: e.quantity,
                price: e.price,
              ),
            )
            .toList());

    await repository.saveOrder(order);
    emit(OrderSaved());
  }

  Future<void> completeOrder() async {
    final List<Product> orderProducts = _allProducts.where((e) => e.quantity > 0).toList();
    if (orderProducts.isEmpty) return;

    final OrderSaveModel order = OrderSaveModel(
        orderId: _order.id,
        orderDate: _order.orderDate,
        seatId: _order.seatId,
        status: OrderPref.ORDER_STATUS_COMPLETE,
        products: orderProducts
            .map(
              (e) => OrderProductSaveModel(
                orderId: _order.id,
                productId: e.id,
                quantity: e.quantity,
                price: e.price,
              ),
            )
            .toList());

    await repository.saveOrder(order);
    emit(OrderSaved());
  }

  void _onSuccess({int? productTypeId, String searchQuery = ''}) {
    List<Product> filteredProducts = List.from(_allProducts);

    if (productTypeId != null) {
      filteredProducts = filteredProducts.where((p) => p.productTypeId == productTypeId).toList();
    }

    if (searchQuery.isNotEmpty) {
      filteredProducts = filteredProducts
          .where((p) => p.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    final totalAmount =
        _allProducts.fold(0.0, (sum, product) => sum + (product.price * product.quantity));
    final totalQuantity = _allProducts.fold(0, (sum, product) => sum + product.quantity);

    emit(
      OrderLoadSuccess(
        products: _allProducts,
        filteredProducts: filteredProducts,
        selectedTypeId: productTypeId,
        totalAmount: totalAmount,
        totalQuantity: totalQuantity,
        productTypes: _productTypes,
        orderStatus: _order.status,
      ),
    );
  }
}
