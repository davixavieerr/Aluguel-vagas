// Caminho: lib/features/auth/presentation/support_screen.dart

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  static const _faqs = [
    _Faq(
      question: 'Como funciona o contrato mensal de vaga?',
      answer:
          'Você combina o valor e a duração mínima direto no app. O pagamento '
          'é recorrente e o acesso à garagem é liberado por QR Code, '
          'controle ou lista na portaria, conforme o anfitrião configurar.',
    ),
    _Faq(
      question: 'Como cancelo uma reserva?',
      answer:
          'Acesse "Reservas", selecione a reserva ativa e toque em cancelar. '
          'Contratos mensais têm regras de cancelamento definidas pelo '
          'anfitrião no anúncio da vaga.',
    ),
    _Faq(
      question: 'O que fazer se a vaga anunciada não existir mais?',
      answer:
          'Use o chat com o anfitrião/portaria dentro da reserva para '
          'resolver diretamente, ou acione o suporte pelos canais abaixo '
          'para mediação.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardSurface,
        title: const Text('Suporte e Ajuda',
            style: TextStyle(color: AppColors.textPrimary)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Fale com a gente',
              style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildContactTile(
            context,
            icon: Icons.chat_bubble_rounded,
            title: 'WhatsApp',
            subtitle: 'Resposta em até 15 min',
            color: AppColors.statusGreen,
          ),
          _buildContactTile(
            context,
            icon: Icons.email_rounded,
            title: 'E-mail',
            subtitle: 'suporte@parkingapp.com.br',
            color: AppColors.primaryBlue,
          ),
          const SizedBox(height: 24),
          const Text('Perguntas frequentes',
              style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          for (final faq in _faqs) _buildFaqTile(faq),
        ],
      ),
    );
  }

  Widget _buildContactTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(title,
            style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 14)),
        subtitle: Text(subtitle,
            style:
                const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios,
            color: AppColors.textSecondary, size: 14),
        onTap: () {
          // TODO: usar url_launcher para abrir WhatsApp/e-mail de verdade
          // (wa.me/... ou mailto:...). Deixei o clique já funcional
          // como placeholder pra não travar a navegação.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Abrindo $title...')),
          );
        },
      ),
    );
  }

  Widget _buildFaqTile(_Faq faq) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Theme(
        data: ThemeData(
          dividerColor: Colors.transparent,
          colorScheme: const ColorScheme.dark(),
        ),
        child: ExpansionTile(
          title: Text(faq.question,
              style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600)),
          iconColor: AppColors.textSecondary,
          collapsedIconColor: AppColors.textSecondary,
          childrenPadding:
              const EdgeInsets.fromLTRB(16, 0, 16, 16),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(faq.answer,
                style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    height: 1.4)),
          ],
        ),
      ),
    );
  }
}

class _Faq {
  final String question;
  final String answer;

  const _Faq({required this.question, required this.answer});
}