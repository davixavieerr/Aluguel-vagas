// Caminho: lib/features/map/presentation/widgets/spot_details_card.dart

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../shared/models/parking_spot_model.dart';

class SpotDetailsCard extends StatelessWidget {
  final ParkingSpot spot;
  final VoidCallback onReserve;
  final VoidCallback onWaitlist;
  final VoidCallback? onClose;

  const SpotDetailsCard({
    super.key,
    required this.spot,
    required this.onReserve,
    required this.onWaitlist,
    this.onClose,
  });

  Color _getStatusColor(SpotAvailabilityStatus status) {
    switch (status) {
      case SpotAvailabilityStatus.available:
        return AppColors.statusGreen;
      case SpotAvailabilityStatus.limited:
        return AppColors.statusYellow;
      case SpotAvailabilityStatus.full:
        return AppColors.statusRed;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFull = spot.status == SpotAvailabilityStatus.full;
    final statusColor = _getStatusColor(spot.status);
    final isMonthly = spot.pricePerMonth != null;
    final hasPhoto = spot.photos.isNotEmpty;

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(24),
        border:
            Border.all(color: statusColor.withValues(alpha: 0.3), width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      // clipBehavior garante que a foto respeite os cantos arredondados do card
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Foto da vaga (se cadastrada em spot.photos), estilo preview
          // do Google Maps. Sem foto -> placeholder discreto.
          _SpotPhotoHeader(
            hasPhoto: hasPhoto,
            photoUrl: hasPhoto ? spot.photos.first : null,
            photoCount: spot.photos.length,
            onClose: onClose,
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tipo de Contrato e Tag
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isMonthly
                            ? AppColors.primaryBlue.withValues(alpha: 0.2)
                            : Colors.orange.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        isMonthly
                            ? 'CONTRATO MENSAL (P2P)'
                            : 'ROTATIVO / HORISTA',
                        style: TextStyle(
                          color:
                              isMonthly ? AppColors.primaryBlue : Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: statusColor),
                      ),
                      child: Text(
                        isFull ? 'Ocupada' : 'Vaga Livre',
                        style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Nome e Endereço
                Text(
                  spot.buildingName,
                  style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  spot.address,
                  style: const TextStyle(
                      color: AppColors.textSecondary, fontSize: 12),
                ),
                const Divider(color: Colors.white10, height: 20),

                // Preço e Avaliação
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isMonthly ? 'Valor mensal' : 'Valor por hora',
                          style: const TextStyle(
                              color: AppColors.textSecondary, fontSize: 11),
                        ),
                        Text(
                          isMonthly
                              ? '${Formatters.formatCurrency(spot.pricePerMonth!)}/mês'
                              : '${Formatters.formatCurrency(spot.pricePerHour ?? 0.0)}/h',
                          style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded,
                            color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          '${spot.rating} (${spot.totalReviews})',
                          style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Botão de Ação
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isFull
                          ? AppColors.statusRed
                          : AppColors.primaryBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: isFull ? onWaitlist : onReserve,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isFull
                              ? Icons.notifications_active_outlined
                              : (isMonthly
                                  ? Icons.assignment_outlined
                                  : Icons.calendar_today_rounded),
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isFull
                              ? 'Avise-me quando desocupar'
                              : (isMonthly
                                  ? 'Ver Termos e Alugar Mensal'
                                  : 'Reservar Vaga Agora'),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Header de foto do card, estilo preview do Google Maps.
/// - Se a vaga tem foto (spot.photos não vazio): mostra spot.photos.first,
///   com selo indicando quantas fotos existem (ex: "1/4").
/// - Se não tem foto: mostra um placeholder discreto com ícone de vaga,
///   pra não deixar o card com espaço em branco quebrado.
class _SpotPhotoHeader extends StatelessWidget {
  final bool hasPhoto;
  final String? photoUrl;
  final int photoCount;
  final VoidCallback? onClose;

  const _SpotPhotoHeader({
    required this.hasPhoto,
    required this.photoUrl,
    required this.photoCount,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (hasPhoto)
            Image.network(
              photoUrl!,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                  color: AppColors.cardSurface,
                  child: const Center(
                    child: SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) =>
                  const _PhotoPlaceholder(),
            )
          else
            const _PhotoPlaceholder(),

          // Gradiente sutil pra dar contraste ao botão de fechar
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.35),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.4],
              ),
            ),
          ),

          // Selo com contagem de fotos (ex: "1/4"), só aparece se houver foto
          if (hasPhoto && photoCount > 1)
            Positioned(
              left: 12,
              bottom: 12,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.photo_library_outlined,
                        color: Colors.white, size: 12),
                    const SizedBox(width: 4),
                    Text(
                      '1/$photoCount',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),

          // Botão de fechar (mantém o comportamento do card original)
          if (onClose != null)
            Positioned(
              right: 8,
              top: 8,
              child: Material(
                color: Colors.black.withValues(alpha: 0.45),
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: onClose,
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.close, color: Colors.white, size: 18),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PhotoPlaceholder extends StatelessWidget {
  const _PhotoPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.cardSurface,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.local_parking_rounded,
              color: AppColors.textSecondary.withValues(alpha: 0.5), size: 32),
          const SizedBox(height: 6),
          Text(
            'Sem foto cadastrada',
            style: TextStyle(
                color: AppColors.textSecondary.withValues(alpha: 0.7),
                fontSize: 11),
          ),
        ],
      ),
    );
  }
}