// lib/shared/models/booking_model.dart
enum BookingStatus { pending, confirmed, active, completed, cancelled }
enum PaymentStatus { authorized, captured, refunded, failed }

class Booking {
  final String id;
  final String spotId;
  final String renterId;
  final String hostId;
  final DateTime startTime;
  final DateTime endTime;
  final double totalAmount;
  final BookingStatus status;
  final PaymentStatus paymentStatus;
  final String qrCodeToken;
  final DateTime createdAt;

  const Booking({
    required this.id,
    required this.spotId,
    required this.renterId,
    required this.hostId,
    required this.startTime,
    required this.endTime,
    required this.totalAmount,
    required this.status,
    required this.paymentStatus,
    required this.qrCodeToken,
    required this.createdAt,
  });
}