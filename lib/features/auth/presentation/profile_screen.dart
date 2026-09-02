// Caminho: lib/features/auth/presentation/profile_screen.dart

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'payment_methods_screen.dart';
import 'security_documents_screen.dart';
import 'support_screen.dart';

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
            _buildSettingsTile(
              Icons.payment,
              'Métodos de Pagamento',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const PaymentMethodsScreen()),
              ),
            ),
            _buildSettingsTile(
              Icons.security,
              'Segurança e Documentos',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const SecurityDocumentsScreen()),
              ),
            ),
            _buildSettingsTile(
              Icons.help_outline,
              'Suporte e Ajuda',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SupportScreen()),
              ),
            ),
            _buildSettingsTile(
              Icons.logout,
              'Sair da Conta',
              isDestructive: true,
              onTap: () => _confirmLogout(context),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.cardSurface,
        title: const Text('Sair da conta',
            style: TextStyle(color: AppColors.textPrimary)),
        content: const Text(
          'Você precisará entrar novamente para reservar ou anunciar vagas. Deseja continuar?',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancelar',
                style: TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(); // fecha o diálogo

              // TODO: chamar aqui a lógica real de logout, por exemplo:
              //   await AuthRepository.instance.logout();
              // e navegar até a tela de login substituindo toda a pilha:
              //   Navigator.of(context).pushAndRemoveUntil(
              //     MaterialPageRoute(builder: (_) => const LoginScreen()),
              //     (route) => false,
              //   );
              // Como o projeto ainda não tem tela de login, por enquanto só
              // fechamos o diálogo e avisamos o usuário.
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sessão encerrada.')),
              );
            },
            child: const Text('Sair',
                style: TextStyle(
                    color: AppColors.statusRed, fontWeight: FontWeight.bold)),
          ),
        ],
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

  Widget _buildSettingsTile(
    IconData icon,
    String title, {
    bool isDestructive = false,
    required VoidCallback onTap,
  }) {
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
        onTap: onTap,
      ),
    );
  }
}