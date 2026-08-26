// Caminho: lib/features/booking/presentation/my_bookings_screen.dart

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../chat/presentation/chat_screen.dart';
import 'qr_code_checkin_screen.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardSurface,
        title: const Text('Minhas Reservas',
            style: TextStyle(color: AppColors.textPrimary)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Reserva Ativa',
              style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),

          // Card de Reserva Ativa
          _buildBookingCard(
            context: context,
            buildingName: 'Edifício Paulista Tower (Residencial)',
            address: 'Alameda Santos, 1470 - Cerqueira César',
            period: 'Hoje das 14:00 às 18:00',
            price: 56.00,
            statusText: 'Check-in Liberado',
            statusColor: AppColors.statusGreen,
            isActive: true,
            hostName: 'Carlos Mendonça (Anfitrião)',
          ),
          const SizedBox(height: 24),

          const Text('Histórico',
              style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),

          // Cards de Histórico
          _buildBookingCard(
            context: context,
            buildingName: 'Estacionamento Top Center (Comercial)',
            address: 'Av. Paulista, 854 - Bela Vista',
            period: '22 de Agosto • 3 horas',
            price: 66.00,
            statusText: 'Concluída',
            statusColor: AppColors.textSecondary,
            isActive: false,
            hostName: 'Gerência Top Center',
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard({
    required BuildContext context,
    required String buildingName,
    required String address,
    required String period,
    required double price,
    required String statusText,
    required Color statusColor,
    required bool isActive,
    required String hostName,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: isActive
                ? AppColors.statusGreen.withValues(alpha: 0.4)
                : Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(buildingName,
                    style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(statusText,
                    style: TextStyle(
                        color: statusColor,
                        fontSize: 11,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(address,
              style: const TextStyle(
                  color: AppColors.textSecondary, fontSize: 13)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(period,
                  style: const TextStyle(
                      color: AppColors.primaryBlue,
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
              Text(Formatters.formatCurrency(price),
                  style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
            ],
          ),
          const Divider(color: Colors.white10, height: 20),

          // Botões de Ação
          Row(
            children: [
              if (isActive) ...[
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.statusGreen,
                      side: const BorderSide(color: AppColors.statusGreen),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: const Icon(Icons.qr_code, size: 18),
                    label: const Text('Ver QR Code'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => QRCodeCheckinScreen(
                            spotName: buildingName,
                            address: address,
                            validUntil:
                                DateTime.now().add(const Duration(hours: 4)),
                            qrPayload: 'PARK-ACTIVE-789456',
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  icon: const Icon(Icons.chat_outlined, size: 18),
                  label: const Text('Chat Portaria'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatScreen(
                            hostName: hostName, spotName: buildingName),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
