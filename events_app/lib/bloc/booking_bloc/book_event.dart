abstract class BookingEvent {}

class LoadBookings extends BookingEvent {}

class CancelBooking extends BookingEvent {
  final int bookingId;
  CancelBooking(this.bookingId);
}
