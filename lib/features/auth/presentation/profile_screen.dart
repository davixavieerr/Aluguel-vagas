// Caminho: lib/features/auth/presentation/profile_screen.dart

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isHostMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardSurface,
        title: const Text('Meu Perfil',
            style: TextStyle(color: AppColors.textPrimary)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 44,
                    backgroundColor: AppColors.primaryBlue,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: AppColors.statusGreen,
                      child:
                          Icon(Icons.verified, size: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text('Davi Xavier',
                style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            const Text('davi.amaral@email.com',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem(
                      '4.9', 'Avaliação', Icons.star_rounded, Colors.amber),
                  const SizedBox(
                      height: 30,
                      child: VerticalDivider(color: Colors.white12)),
                  _buildStatItem('18', 'Locações', Icons.directions_car_rounded,
                      AppColors.primaryBlue),
                  const SizedBox(
                      height: 30,
                      child: VerticalDivider(color: Colors.white12)),
                  _buildStatItem('CNH OK', 'Verificação',
                      Icons.verified_user_rounded, AppColors.statusGreen),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: _isHostMode
                        ? AppColors.primaryBlue
                        : Colors.transparent),
              ),
              child: Row(
                children: [
                  Icon(
                      _isHostMode
                          ? Icons.garage_rounded
                          : Icons.drive_eta_rounded,
                      color: AppColors.primaryBlue,
                      size: 28),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            _isHostMode
                                ? 'Modo Anfitrião (Locador)'
                                : 'Modo Motorista (Locatário)',
                            style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                        Text(
                            _isHostMode
                                ? 'Gerenciando suas vagas anunciadas'
                                : 'Buscando vagas para estacionar',
                            style: const TextStyle(
                                color: AppColors.textSecondary, fontSize: 12)),
                      ],
                    ),
                  ),
                  Switch(
                    value: _isHostMode,
                    activeThumbColor: AppColors.primaryBlue,
                    onChanged: (val) => setState(() => _isHostMode = val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSettingsTile(Icons.payment, 'Métodos de Pagamento'),
            _buildSettingsTile(Icons.security, 'Segurança e Documentos'),
            _buildSettingsTile(Icons.help_outline, 'Suporte e Ajuda'),
            _buildSettingsTile(Icons.logout, 'Sair da Conta',
                isDestructive: true),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
      String value, String label, IconData icon, Color iconColor) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 18),
            const SizedBox(width: 4),
            Text(value,
                style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
          ],
        ),
        const SizedBox(height: 4),
        Text(label,
            style:
                const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
      ],
    );
  }

  Widget _buildSettingsTile(IconData icon, String title,
      {bool isDestructive = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon,
            color:
                isDestructive ? AppColors.statusRed : AppColors.textSecondary),
        title: Text(title,
            style: TextStyle(
                color:
                    isDestructive ? AppColors.statusRed : AppColors.textPrimary,
                fontSize: 14)),
        trailing: const Icon(Icons.arrow_forward_ios,
            color: AppColors.textSecondary, size: 14),
        onTap: () {},
      ),
    );
  }
}
