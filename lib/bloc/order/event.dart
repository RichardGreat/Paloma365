

abstract class OrderEvent {}


class LoadProducts extends OrderEvent {
  final int? orderId;
  final int seatId;

  LoadProducts({required this.orderId, required this.seatId});
}

class UpdateProductQuantity extends OrderEvent {
  final int productId;
  final int quantity;

  UpdateProductQuantity(this.productId, this.quantity);
}

class FilterProductsByType extends OrderEvent {
  final int typeId;

  FilterProductsByType(this.typeId);
}

class SearchProducts extends OrderEvent {
  final String query;

  SearchProducts(this.query);
}

class SaveOrder extends OrderEvent {}

class CompleteOrder extends OrderEvent {}
