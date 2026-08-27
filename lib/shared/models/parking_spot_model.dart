// Caminho: lib/shared/models/parking_spot_model.dart

enum SpotType { residential, commercial }

enum VehicleSize { compact, sedan, suv, motorcycle }

enum AccessMethod { qrCode, remoteControl, conciergeList }

enum RentalModality { monthlyOnly, hourlyOnly, both }

enum SpotAvailabilityStatus {
  available, // Verde (> 3 vagas ou vaga mensal livre)
  limited, // Amarelo (1 a 3 vagas)
  full, // Vermelho (0 vagas / Ocupada)
}

class ParkingSpot {
  final String id;
  final String hostId;
  final String buildingName;
  final String address;
  final double latitude;
  final double longitude;
  final SpotType spotType;
  final RentalModality modality; // Mensal, Horista ou Ambos
  final VehicleSize maxVehicleSize;
  final AccessMethod accessMethod;
  final int totalSpots;
  final int availableSpots;
  final double? pricePerHour;
  final double? pricePerMonth; // Valor do aluguel mensal por contrato
  final int minContractMonths; // Tempo mínimo de contrato (ex: 1, 3, 6 meses)
  final String condominiumRules;
  final bool allowsExternalGuests;
  final double rating;
  final int totalReviews;
  final List<String> photos;

  const ParkingSpot({
    required this.id,
    required this.hostId,
    required this.buildingName,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.spotType,
    required this.modality,
    required this.maxVehicleSize,
    required this.accessMethod,
    required this.totalSpots,
    required this.availableSpots,
    this.pricePerHour,
    this.pricePerMonth,
    this.minContractMonths = 1,
    required this.condominiumRules,
    required this.allowsExternalGuests,
    this.rating = 5.0,
    this.totalReviews = 0,
    this.photos = const [],
  });

  SpotAvailabilityStatus get status {
    if (availableSpots == 0) return SpotAvailabilityStatus.full;
    if (availableSpots <= 3) return SpotAvailabilityStatus.limited;
    return SpotAvailabilityStatus.available;
  }
}
