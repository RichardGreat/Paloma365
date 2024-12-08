import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paloma365/bloc/history/event.dart';
import 'package:paloma365/bloc/history/state.dart';
import 'package:paloma365/repository/history/history_repository.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryRepository repository;

  HistoryBloc({required this.repository}) : super(HistoryInitial()) {
    on<LoadHistory>((event, emit) => loadHistory(event, emit));

    add(LoadHistory());
  }

  Future<void> loadHistory(HistoryEvent event, Emitter<HistoryState> emit) async {
    final orderHistory = await repository.getOrdersHistory();

    emit(HistoryLoadSuccess(orderHistory));
  }
}
