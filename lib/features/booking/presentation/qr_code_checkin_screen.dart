// Caminho: lib/features/booking/presentation/qr_code_checkin_screen.dart

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/custom_button.dart';

class QRCodeCheckinScreen extends StatelessWidget {
  final String spotName;
  final String address;
  final DateTime validUntil;
  final String qrPayload;

  const QRCodeCheckinScreen({
    super.key,
    required this.spotName,
    required this.address,
    required this.validUntil,
    required this.qrPayload,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardSurface,
        title: const Text('Comprovante de Check-in',
            style: TextStyle(color: AppColors.textPrimary)),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.cardSurface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                  color: AppColors.statusGreen.withValues(alpha: 0.5)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle_rounded,
                    color: AppColors.statusGreen, size: 56),
                const SizedBox(height: 12),
                const Text(
                  'Reserva Confirmada!',
                  style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(spotName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 14)),
                const Divider(color: Colors.white10, height: 32),

                // Simulação Visual do QR Code
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.qr_code_2_rounded,
                            size: 120, color: Colors.black),
                        Text(qrPayload.substring(0, 12),
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 10,
                                fontFamily: 'monospace')),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Apresente este código na portaria para liberação.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.textSecondary.withValues(alpha: 0.8),
                      fontSize: 13),
                ),
                const SizedBox(height: 8),
                Text(
                  'Válido até: ${Formatters.formatDateTime(validUntil)}',
                  style: const TextStyle(
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
                const SizedBox(height: 24),

                CustomButton(
                  text: 'Voltar ao Mapa',
                  onPressed: () =>
                      Navigator.popUntil(context, (route) => route.isFirst),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
