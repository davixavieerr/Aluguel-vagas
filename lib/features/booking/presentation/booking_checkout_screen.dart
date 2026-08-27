// Caminho: lib/features/booking/presentation/booking_checkout_screen.dart

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/models/parking_spot_model.dart';
import '../../../shared/widgets/custom_button.dart';
import 'qr_code_checkin_screen.dart';

class BookingCheckoutScreen extends StatefulWidget {
  final ParkingSpot spot;

  const BookingCheckoutScreen({super.key, required this.spot});

  @override
  State<BookingCheckoutScreen> createState() => _BookingCheckoutScreenState();
}

class _BookingCheckoutScreenState extends State<BookingCheckoutScreen> {
  int _selectedDuration = 1; // Meses (se mensal) ou Horas (se horista)
  String _selectedPaymentMethod = 'PIX';
  bool _isProcessing = false;

  bool get _isMonthly => widget.spot.pricePerMonth != null;

  double get _totalPrice {
    if (_isMonthly) {
      return (widget.spot.pricePerMonth ?? 0.0) * _selectedDuration;
    }
    return (widget.spot.pricePerHour ?? 0.0) * _selectedDuration;
  }

  void _confirmBooking() async {
    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    setState(() => _isProcessing = false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => QRCodeCheckinScreen(
          spotName: widget.spot.buildingName,
          address: widget.spot.address,
          validUntil: _isMonthly
              ? DateTime.now().add(Duration(days: 30 * _selectedDuration))
              : DateTime.now().add(Duration(hours: _selectedDuration)),
          qrPayload:
              'PARK-${widget.spot.id}-${DateTime.now().millisecondsSinceEpoch}',
        ),
      ),
    );
  }

  Widget _buildDurationButton(int value, String label) {
    final isSelected = _selectedDuration == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedDuration = value),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryBlue : AppColors.cardSurface,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardSurface,
        title: Text(
          _isMonthly ? 'Contrato de Locação Mensal' : 'Resumo da Reserva',
          style: const TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.spot.buildingName,
              style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              widget.spot.address,
              style:
                  const TextStyle(color: AppColors.textSecondary, fontSize: 14),
            ),
            const SizedBox(height: 24),

            // Seletor de Duração (Meses para Contrato ou Horas para Rotativo)
            Text(
              _isMonthly ? 'Duração do Contrato' : 'Duração Estimada',
              style: const TextStyle(
                  color: AppColors.textPrimary, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: _isMonthly
                  ? [
                      _buildDurationButton(1, '1 mês'),
                      _buildDurationButton(3, '3 meses'),
                      _buildDurationButton(6, '6 meses'),
                      _buildDurationButton(12, '1 ano'),
                    ]
                  : [
                      _buildDurationButton(1, '1 h'),
                      _buildDurationButton(2, '2 h'),
                      _buildDurationButton(4, '4 h'),
                      _buildDurationButton(8, '8 h'),
                    ],
            ),
            const SizedBox(height: 24),

            // Forma de Pagamento
            const Text('Forma de Pagamento',
                style: TextStyle(
                    color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildPaymentOption(
                'PIX',
                _isMonthly
                    ? 'Pagamento recorrente mensal'
                    : 'Aprovação Imediata',
                Icons.pix),
            _buildPaymentOption(
                'Cartão de Crédito',
                _isMonthly
                    ? 'Cobrança mensal automática'
                    : 'Retenção até o check-in',
                Icons.credit_card),

            const Spacer(),

            // Resumo de Valores
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _isMonthly ? 'Valor Total do Contrato:' : 'Total:',
                  style: const TextStyle(
                      color: AppColors.textSecondary, fontSize: 16),
                ),
                Text(
                  Formatters.formatCurrency(_totalPrice),
                  style: const TextStyle(
                      color: AppColors.statusGreen,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomButton(
              text:
                  _isMonthly ? 'Assinar Contrato e Pagar' : 'Confirmar e Pagar',
              isLoading: _isProcessing,
              onPressed: _confirmBooking,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String title, String subtitle, IconData icon) {
    final isSelected = _selectedPaymentMethod == title;
    return GestureDetector(
      onTap: () => setState(() => _selectedPaymentMethod = title),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
              color: isSelected ? AppColors.primaryBlue : Colors.transparent,
              width: 1.5),
        ),
        child: Row(
          children: [
            Icon(icon,
                color: isSelected
                    ? AppColors.primaryBlue
                    : AppColors.textSecondary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold)),
                  Text(subtitle,
                      style: const TextStyle(
                          color: AppColors.textSecondary, fontSize: 12)),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppColors.primaryBlue),
          ],
        ),
      ),
    );
  }
}
