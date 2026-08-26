// Caminho: lib/features/spots/presentation/spot_details_screen.dart

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/models/parking_spot_model.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../booking/presentation/booking_checkout_screen.dart';

class SpotDetailsScreen extends StatelessWidget {
  final ParkingSpot spot;

  const SpotDetailsScreen({super.key, required this.spot});

  String _getVehicleSizeLabel(VehicleSize size) {
    switch (size) {
      case VehicleSize.compact:
        return 'Carros Compactos / Hatch';
      case VehicleSize.sedan:
        return 'Sedans e Médios';
      case VehicleSize.suv:
        return 'SUVs e Camionetes';
      case VehicleSize.motorcycle:
        return 'Apenas Motos';
    }
  }

  String _getAccessMethodLabel(AccessMethod method) {
    switch (method) {
      case AccessMethod.qrCode:
        return 'QR Code na Portaria / Cancela Automática';
      case AccessMethod.remoteControl:
        return 'Controle Remoto entregue pelo Anfitrião';
      case AccessMethod.conciergeList:
        return 'Identificação prévia com CNH na Portaria';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFull = spot.status == SpotAvailabilityStatus.full;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardSurface,
        title: const Text('Detalhes da Vaga',
            style: TextStyle(color: AppColors.textPrimary)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Principal
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          spot.spotType == SpotType.residential
                              ? 'Residencial (P2P)'
                              : 'Comercial (B2C)',
                          style: const TextStyle(
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded,
                              color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            '${spot.rating} (${spot.totalReviews})',
                            style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    spot.buildingName,
                    style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    spot.address,
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Especificações da Vaga
            const Text(
              'Informações e Acesso',
              style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildInfoTile(Icons.directions_car_outlined, 'Porte do Veículo',
                _getVehicleSizeLabel(spot.maxVehicleSize)),
            _buildInfoTile(Icons.qr_code_2_rounded, 'Método de Acesso',
                _getAccessMethodLabel(spot.accessMethod)),
            _buildInfoTile(Icons.verified_user_outlined, 'Regras do Condomínio',
                spot.condominiumRules),
            const SizedBox(height: 24),

            // Preço e Botão de Ação
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Valor da hora',
                          style: TextStyle(
                              color: AppColors.textSecondary, fontSize: 12)),
                      Text(
                        Formatters.formatCurrency(spot.pricePerHour),
                        style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CustomButton(
                      text: isFull
                          ? 'Ativar Alerta (Waitlist)'
                          : 'Continuar Reserva',
                      backgroundColor:
                          isFull ? AppColors.statusRed : AppColors.primaryBlue,
                      icon: isFull
                          ? Icons.notifications_active_outlined
                          : Icons.arrow_forward_rounded,
                      onPressed: () {
                        if (!isFull) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BookingCheckoutScreen(spot: spot),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.cardSurface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primaryBlue, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 12)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: const TextStyle(
                        color: AppColors.textPrimary, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
