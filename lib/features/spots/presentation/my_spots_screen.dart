// Caminho: lib/features/spots/presentation/my_spots_screen.dart

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../data/spots_repository.dart';
import 'add_spot_screen.dart';

class MySpotsScreen extends StatelessWidget {
  const MySpotsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: SpotsRepository.instance,
      builder: (context, _) {
        final mySpots = SpotsRepository.instance.mySpots;

        return Scaffold(
          backgroundColor: AppColors.darkBackground,
          appBar: AppBar(
            backgroundColor: AppColors.cardSurface,
            title: const Text('Minhas Vagas Anunciadas',
                style: TextStyle(color: AppColors.textPrimary)),
            actions: [
              IconButton(
                icon: const Icon(Icons.add, color: AppColors.primaryBlue),
                tooltip: 'Anunciar Outra Vaga',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddSpotScreen()),
                  );
                },
              ),
            ],
          ),
          body: mySpots.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.garage_outlined,
                            size: 64, color: AppColors.textSecondary),
                        const SizedBox(height: 16),
                        const Text(
                          'Você ainda não anunciou nenhuma vaga',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Monetize a vaga ociosa do seu condomínio com contratos mensais seguros.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.textSecondary, fontSize: 13),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          icon: const Icon(Icons.add, color: Colors.white),
                          label: const Text('Anunciar Minha Vaga Agora',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const AddSpotScreen()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: mySpots.length,
                  itemBuilder: (context, index) {
                    final spot = mySpots[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.cardSurface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color:
                                AppColors.statusGreen.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.statusGreen
                                      .withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text('ATIVA NO MAPA',
                                    style: TextStyle(
                                        color: AppColors.statusGreen,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold)),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline,
                                    color: AppColors.statusRed, size: 20),
                                onPressed: () {
                                  SpotsRepository.instance.removeSpot(spot.id);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Vaga removida da plataforma.')),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(spot.buildingName,
                              style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          Text(spot.address,
                              style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 13)),
                          const Divider(color: Colors.white10, height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                spot.pricePerMonth != null
                                    ? '${Formatters.formatCurrency(spot.pricePerMonth!)}/mês'
                                    : '${Formatters.formatCurrency(spot.pricePerHour ?? 0)}/h',
                                style: const TextStyle(
                                    color: AppColors.primaryBlue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              Text('${spot.minContractMonths} mês(es) mín.',
                                  style: const TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
