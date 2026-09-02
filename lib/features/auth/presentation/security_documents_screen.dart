// Caminho: lib/features/auth/presentation/security_documents_screen.dart

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class SecurityDocumentsScreen extends StatelessWidget {
  const SecurityDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardSurface,
        title: const Text('Segurança e Documentos',
            style: TextStyle(color: AppColors.textPrimary)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildDocStatusTile(
            icon: Icons.badge_rounded,
            title: 'CNH',
            subtitle: 'Verificada em 12/03/2026',
            verified: true,
          ),
          _buildDocStatusTile(
            icon: Icons.face_retouching_natural_rounded,
            title: 'Identidade (selfie)',
            subtitle: 'Verificada em 12/03/2026',
            verified: true,
          ),
          _buildDocStatusTile(
            icon: Icons.directions_car_filled_rounded,
            title: 'Documento do veículo (CRLV)',
            subtitle: 'Pendente de envio',
            verified: false,
          ),
          const SizedBox(height: 20),
          const Text('Segurança da conta',
              style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildActionTile(
            context,
            icon: Icons.lock_outline_rounded,
            title: 'Alterar senha',
            onTap: () => _showComingSoon(context, 'Alteração de senha'),
          ),
          _buildActionTile(
            context,
            icon: Icons.phonelink_lock_rounded,
            title: 'Verificação em duas etapas',
            trailingText: 'Desativada',
            onTap: () => _showComingSoon(context, 'Verificação em duas etapas'),
          ),
          _buildActionTile(
            context,
            icon: Icons.devices_other_rounded,
            title: 'Dispositivos conectados',
            onTap: () => _showComingSoon(context, 'Dispositivos conectados'),
          ),
        ],
      ),
    );
  }

  Widget _buildDocStatusTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool verified,
  }) {
    final statusColor = verified ? AppColors.statusGreen : AppColors.statusYellow;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: statusColor, size: 24),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Icon(
            verified ? Icons.check_circle_rounded : Icons.upload_rounded,
            color: statusColor,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? trailingText,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.textSecondary),
        title: Text(title,
            style:
                const TextStyle(color: AppColors.textPrimary, fontSize: 14)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (trailingText != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(trailingText,
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 12)),
              ),
            const Icon(Icons.arrow_forward_ios,
                color: AppColors.textSecondary, size: 14),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$feature em breve.')),
    );
  }
}