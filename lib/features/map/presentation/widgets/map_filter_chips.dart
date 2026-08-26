import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class MapFilterChips extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onFilterSelected;
  final List<String> filters;

  const MapFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
    this.filters = const ['Todos', 'Residencial', 'Comercial', 'Disponíveis'],
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = selectedFilter == filter;

          return FilterChip(
            label: Text(filter),
            selected: isSelected,
            onSelected: (_) => onFilterSelected(filter),
            backgroundColor: AppColors.cardSurface.withValues(alpha: 0.9),
            selectedColor: AppColors.primaryBlue,
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : AppColors.textPrimary,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 13,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: isSelected ? AppColors.primaryBlue : Colors.white12,
              ),
            ),
          );
        },
      ),
    );
  }
}