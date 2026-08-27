// Caminho: lib/features/map/presentation/map_home_screen.dart

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/constants/map_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/parking_spot_model.dart';
import '../../spots/data/spots_repository.dart';
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

  Set<Marker> _buildMarkers(List<ParkingSpot> spots) {
    return spots.where((spot) {
      if (_selectedFilter == 'Contrato Mensal') {
        return spot.modality == RentalModality.monthlyOnly ||
            spot.modality == RentalModality.both;
      }
      if (_selectedFilter == 'Por Hora') {
        return spot.modality == RentalModality.hourlyOnly ||
            spot.modality == RentalModality.both;
      }
      if (_selectedFilter == 'Residencial (P2P)') {
        return spot.spotType == SpotType.residential;
      }
      if (_selectedFilter == 'Disponíveis') {
        return spot.availableSpots > 0;
      }
      return true;
    }).map((spot) {
      final isMonthly = spot.pricePerMonth != null;
      final priceSnippet = isMonthly
          ? 'R\$ ${spot.pricePerMonth!.toStringAsFixed(0)}/mês (Contrato)'
          : 'R\$ ${spot.pricePerHour?.toStringAsFixed(2)}/h';

      return Marker(
        markerId: MarkerId(spot.id),
        position: LatLng(spot.latitude, spot.longitude),
        icon: _getMarkerHue(spot.status),
        infoWindow: InfoWindow(
          title: spot.buildingName,
          snippet:
              '$priceSnippet • ${spot.availableSpots > 0 ? 'Livre' : 'Ocupada'}',
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
        title: const Text('Lista de Espera de Vaga',
            style: TextStyle(color: AppColors.textPrimary)),
        content: Text(
          'A vaga no ${spot.buildingName} está ocupada. Deseja receber uma notificação assim que for desocupada?',
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
                  content:
                      Text('Alerta de vaga ativado para ${spot.buildingName}!'),
                ),
              );
            },
            child: const Text('Ativar Alerta',
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
    return ListenableBuilder(
      listenable: SpotsRepository.instance,
      builder: (context, _) {
        final allSpots = SpotsRepository.instance.spots;

        return Scaffold(
          backgroundColor: AppColors.darkBackground,
          body: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: _paulistaCenter,
                  zoom: 14.8,
                ),
                style: MapStyle.darkMapJson,
                onMapCreated: (controller) => _mapController = controller,
                markers: _buildMarkers(allSpots),
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                onTap: (_) => setState(() => _selectedSpot = null),
              ),
              SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MapSearchBar(
                      hintText: 'Buscar prédios com vagas na Paulista...',
                      onTap: () {},
                      onFilterTap: () {},
                    ),
                    const SizedBox(height: 8),
                    MapFilterChips(
                      selectedFilter: _selectedFilter,
                      filters: const [
                        'Todos',
                        'Contrato Mensal',
                        'Por Hora',
                        'Residencial (P2P)',
                        'Disponíveis'
                      ],
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
      },
    );
  }
}
