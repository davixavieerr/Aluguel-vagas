// Caminho: lib/features/waitlist/presentation/my_waitlists_screen.dart

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class MyWaitlistsScreen extends StatefulWidget {
  const MyWaitlistsScreen({super.key});

  @override
  State<MyWaitlistsScreen> createState() => _MyWaitlistsScreenState();
}

class _MyWaitlistsScreenState extends State<MyWaitlistsScreen> {
  final List<Map<String, dynamic>> _activeWaitlists = [
    {
      'id': 'w_01',
      'buildingName': 'Condomínio Augusta Central (Residencial)',
      'address': 'Rua Augusta, 1508 - Consolação',
      'status': 'Lotado (0 vagas)',
      'createdAt': 'Criado há 2 horas',
    },
    {
      'id': 'w_02',
      'buildingName': 'Edifício Gazeta Paulista',
      'address': 'Av. Paulista, 900 - Bela Vista',
      'status': 'Lotado (0 vagas)',
      'createdAt': 'Criado ontem',
    },
  ];

  void _removeWaitlist(int index) {
    final removed = _activeWaitlists[index];
    setState(() => _activeWaitlists.removeAt(index));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.cardSurface,
        content: Text('Alerta removido para ${removed['buildingName']}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardSurface,
        title: const Text('Alertas e Fila de Espera',
            style: TextStyle(color: AppColors.textPrimary)),
      ),
      body: _activeWaitlists.isEmpty
          ? const Center(
              child: Text('Você não possui alertas de vagas ativos.',
                  style: TextStyle(color: AppColors.textSecondary)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _activeWaitlists.length,
              itemBuilder: (context, index) {
                final item = _activeWaitlists[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.cardSurface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: AppColors.statusRed.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.statusRed.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.notifications_active,
                            color: AppColors.statusRed, size: 22),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['buildingName'],
                                style: const TextStyle(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                            const SizedBox(height: 2),
                            Text(item['address'],
                                style: const TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 12)),
                            const SizedBox(height: 4),
                            Text(item['createdAt'],
                                style: const TextStyle(
                                    color: AppColors.primaryBlue,
                                    fontSize: 11)),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline,
                            color: AppColors.textSecondary),
                        onPressed: () => _removeWaitlist(index),
                        tooltip: 'Remover Alerta',
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
