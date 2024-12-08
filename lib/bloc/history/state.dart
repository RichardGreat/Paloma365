import 'package:paloma365/kernel/bean/order_history.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoadInProgress extends HistoryState {}

class HistoryLoadSuccess extends HistoryState {
  final List<OrderHistory> orders;

  HistoryLoadSuccess(this.orders);
}
