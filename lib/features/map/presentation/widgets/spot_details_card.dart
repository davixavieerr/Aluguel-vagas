// Caminho: lib/features/map/presentation/widgets/spot_details_card.dart

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../shared/models/parking_spot_model.dart';

class SpotDetailsCard extends StatelessWidget {
  final ParkingSpot spot;
  final VoidCallback onReserve;
  final VoidCallback onWaitlist;
  final VoidCallback? onClose;

  const SpotDetailsCard({
    super.key,
    required this.spot,
    required this.onReserve,
    required this.onWaitlist,
    this.onClose,
  });

  Color _getStatusColor(SpotAvailabilityStatus status) {
    switch (status) {
      case SpotAvailabilityStatus.available:
        return AppColors.statusGreen;
      case SpotAvailabilityStatus.limited:
        return AppColors.statusYellow;
      case SpotAvailabilityStatus.full:
        return AppColors.statusRed;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFull = spot.status == SpotAvailabilityStatus.full;
    final statusColor = _getStatusColor(spot.status);
    final isMonthly = spot.pricePerMonth != null;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(24),
        border:
            Border.all(color: statusColor.withValues(alpha: 0.3), width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tipo de Contrato e Tag
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isMonthly
                      ? AppColors.primaryBlue.withValues(alpha: 0.2)
                      : Colors.orange.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isMonthly ? 'CONTRATO MENSAL (P2P)' : 'ROTATIVO / HORISTA',
                  style: TextStyle(
                    color: isMonthly ? AppColors.primaryBlue : Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: statusColor),
                ),
                child: Text(
                  isFull ? 'Ocupada' : 'Vaga Livre',
                  style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 11),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Nome e Endereço
          Text(
            spot.buildingName,
            style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            spot.address,
            style:
                const TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
          const Divider(color: Colors.white10, height: 20),

          // Preço e Avaliação
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isMonthly ? 'Valor mensal' : 'Valor por hora',
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 11),
                  ),
                  Text(
                    isMonthly
                        ? '${Formatters.formatCurrency(spot.pricePerMonth!)}/mês'
                        : '${Formatters.formatCurrency(spot.pricePerHour ?? 0.0)}/h',
                    style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    '${spot.rating} (${spot.totalReviews})',
                    style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Botão de Ação
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isFull ? AppColors.statusRed : AppColors.primaryBlue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: isFull ? onWaitlist : onReserve,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isFull
                        ? Icons.notifications_active_outlined
                        : (isMonthly
                            ? Icons.assignment_outlined
                            : Icons.calendar_today_rounded),
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isFull
                        ? 'Avise-me quando desocupar'
                        : (isMonthly
                            ? 'Ver Termos e Alugar Mensal'
                            : 'Reservar Vaga Agora'),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
