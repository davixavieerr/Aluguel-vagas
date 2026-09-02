// Caminho: lib/features/auth/presentation/payment_methods_screen.dart

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock de métodos já cadastrados. Troque por dados reais quando tiver
    // um repositório/backend de pagamento.
    final methods = [
      _PaymentMethod(
        icon: Icons.pix_rounded,
        title: 'Pix',
        subtitle: 'davi.amaral@email.com',
        isDefault: true,
      ),
      _PaymentMethod(
        icon: Icons.credit_card_rounded,
        title: 'Cartão de crédito',
        subtitle: 'Mastercard •••• 4832',
        isDefault: false,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardSurface,
        title: const Text('Métodos de Pagamento',
            style: TextStyle(color: AppColors.textPrimary)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          for (final method in methods) _buildMethodTile(method),
          const SizedBox(height: 8),
          _buildAddButton(context),
        ],
      ),
    );
  }

  Widget _buildMethodTile(_PaymentMethod method) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: method.isDefault
              ? AppColors.primaryBlue.withValues(alpha: 0.5)
              : Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.15),
            child: Icon(method.icon, color: AppColors.primaryBlue, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(method.title,
                    style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
                const SizedBox(height: 2),
                Text(method.subtitle,
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          if (method.isDefault)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('Padrão',
                  style: TextStyle(
                      color: AppColors.primaryBlue,
                      fontSize: 11,
                      fontWeight: FontWeight.bold)),
            )
          else
            const Icon(Icons.more_vert,
                color: AppColors.textSecondary, size: 18),
        ],
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        // TODO: abrir formulário/gateway de cadastro de novo método de pagamento
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Cadastro de novo método em breve.')),
        );
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryBlue,
        side: const BorderSide(color: AppColors.primaryBlue),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: const Icon(Icons.add),
      label: const Text('Adicionar método de pagamento'),
    );
  }
}

class _PaymentMethod {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isDefault;

  _PaymentMethod({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isDefault,
  });
}