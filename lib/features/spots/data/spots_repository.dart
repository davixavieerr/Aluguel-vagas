// Caminho: lib/features/spots/data/spots_repository.dart

import 'package:flutter/material.dart';
import '../../../shared/models/parking_spot_model.dart';

class SpotsRepository extends ChangeNotifier {
  // Singleton para acesso global em todo o app
  static final SpotsRepository instance = SpotsRepository._internal();
  SpotsRepository._internal();

  final String currentUserId = 'host_me';

  final List<ParkingSpot> _spots = [
    const ParkingSpot(
      id: 'sp_mensal_01',
      hostId: 'host_01',
      buildingName: 'Condomínio Edifício Barão de Capanema',
      address: 'Alameda Santos, 1893 - Cerqueira César',
      latitude: -23.560100,
      longitude: -46.658200,
      spotType: SpotType.residential,
      modality: RentalModality.monthlyOnly,
      maxVehicleSize: VehicleSize.suv,
      accessMethod: AccessMethod.remoteControl,
      totalSpots: 2,
      availableSpots: 1,
      pricePerMonth: 420.00,
      minContractMonths: 3,
      condominiumRules:
          'Morador com 2 vagas alugando 1 vaga livre. Entrega de tag/controle com cadastro na administração.',
      allowsExternalGuests: true,
      rating: 5.0,
      totalReviews: 12,
    ),
    const ParkingSpot(
      id: 'sp_mensal_02',
      hostId: 'host_02',
      buildingName: 'Edifício Residencial Anchieta',
      address: 'Av. Paulista, 2584 - Consolação',
      latitude: -23.556200,
      longitude: -46.662500,
      spotType: SpotType.residential,
      modality: RentalModality.monthlyOnly,
      maxVehicleSize: VehicleSize.sedan,
      accessMethod: AccessMethod.qrCode,
      totalSpots: 1,
      availableSpots: 1,
      pricePerMonth: 380.00,
      minContractMonths: 1,
      condominiumRules:
          'Vaga coberta e demarcada no 2º subsolo. Portaria 24h com liberação digital.',
      allowsExternalGuests: true,
      rating: 4.9,
      totalReviews: 8,
    ),
    const ParkingSpot(
      id: 'sp_rotativo_01',
      hostId: 'host_04',
      buildingName: 'Estacionamento Top Center (Comercial)',
      address: 'Av. Paulista, 854 - Bela Vista',
      latitude: -23.565800,
      longitude: -46.651500,
      spotType: SpotType.commercial,
      modality: RentalModality.both,
      maxVehicleSize: VehicleSize.sedan,
      accessMethod: AccessMethod.conciergeList,
      totalSpots: 10,
      availableSpots: 3,
      pricePerHour: 22.00,
      pricePerMonth: 650.00,
      minContractMonths: 1,
      condominiumRules:
          'Rotativo comercial com seguro total e opção de mensalista.',
      allowsExternalGuests: true,
      rating: 4.7,
      totalReviews: 142,
    ),
  ];

  List<ParkingSpot> get spots => List.unmodifiable(_spots);

  List<ParkingSpot> get mySpots =>
      _spots.where((s) => s.hostId == currentUserId).toList();

  void addSpot(ParkingSpot spot) {
    _spots.insert(0, spot);
    notifyListeners(); // Notifica o Mapa e a lista de Minhas Vagas
  }

  void removeSpot(String id) {
    _spots.removeWhere((s) => s.id == id);
    notifyListeners();
  }
}
