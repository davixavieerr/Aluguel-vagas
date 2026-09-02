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
          // 1. Sua Logo do Estacionei em JPG:
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/logo_estacionei.jpg',
              height: 32,
              width: 32,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),

          // 2. Campo de busca
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

          // 3. Botão de filtros
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
