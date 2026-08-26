// Caminho: lib/features/map/presentation/map_home_screen.dart

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/constants/map_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/parking_spot_model.dart';
import '../../spots/presentation/spot_details_screen.dart';
import 'widgets/map_search_bar.dart';
import 'widgets/map_filter_chips.dart';
import 'widgets/spot_details_card.dart';

class MapHomeScreen extends StatefulWidget {
  const MapHomeScreen({super.key});

  @override
  State<MapHomeScreen> createState() => _MapHomeScreenState();
}

class _MapHomeScreenState extends State<MapHomeScreen> {
  GoogleMapController? _mapController;
  ParkingSpot? _selectedSpot;
  String _selectedFilter = 'Todos';

  static const LatLng _paulistaCenter = LatLng(-23.561414, -46.655881);

  final List<ParkingSpot> _mockSpots = const [
    ParkingSpot(
      id: 'sp_01',
      hostId: 'host_01',
      buildingName: 'Edifício Paulista Tower (Residencial)',
      address: 'Alameda Santos, 1470 - Cerqueira César',
      latitude: -23.563200,
      longitude: -46.654200,
      spotType: SpotType.residential,
      maxVehicleSize: VehicleSize.suv,
      accessMethod: AccessMethod.qrCode,
      totalSpots: 5,
      availableSpots: 4,
      pricePerHour: 14.00,
      pricePerDay: 70.00,
      condominiumRules: 'Portaria 24h. Entrada com QR Code.',
      allowsExternalGuests: true,
      rating: 4.9,
      totalReviews: 28,
    ),
    ParkingSpot(
      id: 'sp_02',
      hostId: 'host_02',
      buildingName: 'Estacionamento Top Center (Comercial)',
      address: 'Av. Paulista, 854 - Bela Vista',
      latitude: -23.565800,
      longitude: -46.651500,
      spotType: SpotType.commercial,
      maxVehicleSize: VehicleSize.sedan,
      accessMethod: AccessMethod.conciergeList,
      totalSpots: 10,
      availableSpots: 2,
      pricePerHour: 22.00,
      pricePerDay: 110.00,
      condominiumRules: 'Rotativo coberto com seguro.',
      allowsExternalGuests: true,
      rating: 4.7,
      totalReviews: 142,
    ),
    ParkingSpot(
      id: 'sp_03',
      hostId: 'host_03',
      buildingName: 'Condomínio Augusta Central (Residencial)',
      address: 'Rua Augusta, 1508 - Consolação',
      latitude: -23.555200,
      longitude: -46.659800,
      spotType: SpotType.residential,
      maxVehicleSize: VehicleSize.compact,
      accessMethod: AccessMethod.remoteControl,
      totalSpots: 3,
      availableSpots: 0,
      pricePerHour: 10.00,
      pricePerDay: 50.00,
      condominiumRules: 'Acesso com liberação na portaria.',
      allowsExternalGuests: true,
      rating: 4.8,
      totalReviews: 19,
    ),
  ];

  BitmapDescriptor _getMarkerHue(SpotAvailabilityStatus status) {
    switch (status) {
      case SpotAvailabilityStatus.available:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      case SpotAvailabilityStatus.limited:
        return BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueYellow);
      case SpotAvailabilityStatus.full:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    }
  }

  Set<Marker> _buildMarkers() {
    return _mockSpots.where((spot) {
      if (_selectedFilter == 'Residencial') {
        return spot.spotType == SpotType.residential;
      }
      if (_selectedFilter == 'Comercial') {
        return spot.spotType == SpotType.commercial;
      }
      if (_selectedFilter == 'Disponíveis') {
        return spot.availableSpots > 0;
      }
      return true;
    }).map((spot) {
      return Marker(
        markerId: MarkerId(spot.id),
        position: LatLng(spot.latitude, spot.longitude),
        icon: _getMarkerHue(spot.status),
        infoWindow: InfoWindow(
          title: spot.buildingName,
          snippet:
              'R\$ ${spot.pricePerHour.toStringAsFixed(2)}/h • ${spot.availableSpots} vagas',
        ),
        onTap: () {
          setState(() {
            _selectedSpot = spot;
          });
          _mapController?.animateCamera(
            CameraUpdate.newLatLngZoom(
              LatLng(spot.latitude, spot.longitude),
              16.5,
            ),
          );
        },
      );
    }).toSet();
  }

  void _showWaitlistDialog(ParkingSpot spot) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardSurface,
        title: const Text('Entrar na Lista de Espera',
            style: TextStyle(color: AppColors.textPrimary)),
        content: Text(
          'O ${spot.buildingName} está sem vagas no momento. Deseja receber uma notificação assim que uma vaga for liberada?',
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar',
                style: TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.primaryBlue,
                  content: Text('Alerta ativado para ${spot.buildingName}!'),
                ),
              );
            },
            child: const Text('Ativar Notificação',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _handleBooking(ParkingSpot spot) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SpotDetailsScreen(spot: spot),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: _paulistaCenter,
              zoom: 15.0,
            ),
            style: MapStyle.darkMapJson,
            onMapCreated: (controller) => _mapController = controller,
            markers: _buildMarkers(),
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onTap: (_) => setState(() => _selectedSpot = null),
          ),
          SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MapSearchBar(
                  onTap: () {},
                  onFilterTap: () {},
                ),
                const SizedBox(height: 8),
                MapFilterChips(
                  selectedFilter: _selectedFilter,
                  onFilterSelected: (filter) {
                    setState(() => _selectedFilter = filter);
                  },
                ),
              ],
            ),
          ),
          if (_selectedSpot != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: SpotDetailsCard(
                spot: _selectedSpot!,
                onReserve: () => _handleBooking(_selectedSpot!),
                onWaitlist: () => _showWaitlistDialog(_selectedSpot!),
                onClose: () => setState(() => _selectedSpot = null),
              ),
            ),
        ],
      ),
    );
  }
}
