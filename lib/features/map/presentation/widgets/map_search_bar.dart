// Caminho: lib/features/map/presentation/widgets/map_search_bar.dart

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class MapSearchBar extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onFilterTap;
  final ValueChanged<String>? onChanged;
  final String hintText;

  const MapSearchBar({
    super.key,
    this.onTap,
    this.onFilterTap,
    this.onChanged,
    this.hintText = 'Onde quer estacionar?',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      height: 54,
      decoration: BoxDecoration(
        color: AppColors.cardSurface.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo com fallback seguro contra erros de carregamento
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/logo_estacionei.jpg',
              height: 32,
              width: 32,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Se a imagem não for encontrada, exibe este ícone sem travar o app:
                return Container(
                  height: 32,
                  width: 32,
                  color: AppColors.primaryBlue,
                  child: const Icon(Icons.local_parking_rounded,
                      color: Colors.white, size: 20),
                );
              },
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Text(
                hintText,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          IconButton(
            icon: const Icon(Icons.tune, color: AppColors.primaryBlue),
            onPressed: onFilterTap,
            tooltip: 'Filtros',
            splashRadius: 20,
          ),
        ],
      ),
    );
  }
}
