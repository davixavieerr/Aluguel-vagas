// Caminho: lib/features/spots/presentation/location_picker_screen.dart

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/constants/map_style.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/custom_button.dart';

class LocationPickerScreen extends StatefulWidget {
  final LatLng initialPosition;

  const LocationPickerScreen({super.key, required this.initialPosition});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  late LatLng _currentCenter;

  @override
  void initState() {
    super.initState();
    _currentCenter = widget.initialPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardSurface,
        title: const Text('Posicione o Portão da Garagem',
            style: TextStyle(color: AppColors.textPrimary, fontSize: 16)),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: widget.initialPosition,
              zoom: 16.5,
            ),
            style: MapStyle.darkMapJson,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onCameraMove: (position) {
              _currentCenter = position.target;
            },
          ),

          // Marcador Fixo no Centro da Tela
          const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 36),
              child: Icon(
                Icons.location_on_rounded,
                size: 48,
                color: AppColors.statusGreen,
              ),
            ),
          ),

          // Botão Inferior de Confirmação
          Positioned(
            bottom: 24,
            left: 20,
            right: 20,
            child: CustomButton(
              text: 'Confirmar Ponto da Garagem',
              backgroundColor: AppColors.primaryBlue,
              onPressed: () => Navigator.pop(context, _currentCenter),
            ),
          ),
        ],
      ),
    );
  }
}
