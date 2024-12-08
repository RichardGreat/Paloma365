import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paloma365/bloc/seats/event.dart';
import 'package:paloma365/bloc/seats/state.dart';
import 'package:paloma365/kernel/bean/seat.dart';
import 'package:paloma365/repository/seat/seats_repository.dart';

class SeatBloc extends Bloc<SeatEvent, SeatState> {
  final SeatsRepository repository;

  SeatBloc({required this.repository}) : super(SeatInitial()) {
    on<LoadSeats>((event, emit) => _loadSeats(event, emit));

    add(LoadSeats());
  }

  Future<void> _loadSeats(SeatEvent event, Emitter<SeatState> emit) async {
    final List<Seat> seats = await repository.getSeats();

    emit(SeatLoadSuccess(seats));
  }
}
