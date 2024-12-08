abstract class SeatEvent {}
class LoadSeats extends SeatEvent {}
class SeatSelected extends SeatEvent {
  final int seatNumber;
  SeatSelected(this.seatNumber);
}