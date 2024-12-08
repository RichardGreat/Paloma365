import 'package:paloma365/kernel/bean/seat.dart';

abstract class SeatState {}

class SeatInitial extends SeatState {}

class SeatLoadInProgress extends SeatState {}

class SeatLoadSuccess extends SeatState {
  final List<Seat> seats;
  SeatLoadSuccess(this.seats);
}
