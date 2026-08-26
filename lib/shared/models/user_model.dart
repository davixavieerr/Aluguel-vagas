// lib/shared/models/user_model.dart
enum UserRole { renter, host, both }

class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String? profilePhotoUrl;
  final UserRole role;
  final double rating;
  final int totalReviews;
  final bool isIdentityVerified;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    this.profilePhotoUrl,
    required this.role,
    this.rating = 5.0,
    this.totalReviews = 0,
    this.isIdentityVerified = false,
  });
}