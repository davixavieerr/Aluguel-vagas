// Caminho: lib/features/spots/presentation/add_spot_screen.dart

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/models/parking_spot_model.dart';
import '../../../shared/widgets/custom_button.dart';

class AddSpotScreen extends StatefulWidget {
  const AddSpotScreen({super.key});

  @override
  State<AddSpotScreen> createState() => _AddSpotScreenState();
}

class _AddSpotScreenState extends State<AddSpotScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _rulesController = TextEditingController();
  final _priceController = TextEditingController();

  SpotType _spotType = SpotType.residential;
  VehicleSize _vehicleSize = VehicleSize.sedan;
  AccessMethod _accessMethod = AccessMethod.qrCode;
  bool _allowsExternalGuests = true;
  bool _isLoading = false;

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1)); // Simula salvamento

    if (!mounted) return;
    setState(() => _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: AppColors.statusGreen,
        content: Text('Vaga cadastrada com sucesso na plataforma!'),
      ),
    );

    _nameController.clear();
    _addressController.clear();
    _rulesController.clear();
    _priceController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardSurface,
        title: const Text('Anunciar Vaga',
            style: TextStyle(color: AppColors.textPrimary)),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tipo de Vaga
              const Text('Tipo de Vaga',
                  style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildChoiceCard(
                      title: 'Residencial (P2P)',
                      subtitle: 'Sua vaga de prédio',
                      isSelected: _spotType == SpotType.residential,
                      onTap: () =>
                          setState(() => _spotType = SpotType.residential),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildChoiceCard(
                      title: 'Comercial (B2C)',
                      subtitle: 'Estacionamento privado',
                      isSelected: _spotType == SpotType.commercial,
                      onTap: () =>
                          setState(() => _spotType = SpotType.commercial),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Informações Básicas
              _buildTextField(
                controller: _nameController,
                label: 'Nome do Edifício / Estacionamento',
                hint: 'Ex: Edifício Paulista Prime',
                validator: (val) =>
                    val!.isEmpty ? 'Informe o nome do edifício' : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _addressController,
                label: 'Endereço Completo',
                hint: 'Ex: Alameda Santos, 1000 - Cerqueira César',
                validator: (val) => val!.isEmpty ? 'Informe o endereço' : null,
              ),
              const SizedBox(height: 16),

              // Porte do Veículo
              const Text('Porte Máximo Aceito',
                  style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<VehicleSize>(
                value: _vehicleSize,
                dropdownColor: AppColors.cardSurface,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: _inputDecoration(),
                items: const [
                  DropdownMenuItem(
                      value: VehicleSize.compact,
                      child: Text('Carro Compacto (Hatch)')),
                  DropdownMenuItem(
                      value: VehicleSize.sedan, child: Text('Sedan / Médio')),
                  DropdownMenuItem(
                      value: VehicleSize.suv, child: Text('SUV / Camionete')),
                  DropdownMenuItem(
                      value: VehicleSize.motorcycle,
                      child: Text('Apenas Motocicleta')),
                ],
                onChanged: (val) => setState(() => _vehicleSize = val!),
              ),
              const SizedBox(height: 16),

              // Método de Acesso
              const Text('Método de Entrada na Portaria',
                  style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<AccessMethod>(
                value: _accessMethod,
                dropdownColor: AppColors.cardSurface,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: _inputDecoration(),
                items: const [
                  DropdownMenuItem(
                      value: AccessMethod.qrCode,
                      child: Text('QR Code Digital')),
                  DropdownMenuItem(
                      value: AccessMethod.remoteControl,
                      child: Text('Controle Remoto com Anfitrião')),
                  DropdownMenuItem(
                      value: AccessMethod.conciergeList,
                      child: Text('Lista de Autorização na Portaria')),
                ],
                onChanged: (val) => setState(() => _accessMethod = val!),
              ),
              const SizedBox(height: 16),

              // Preço por Hora
              _buildTextField(
                controller: _priceController,
                label: 'Preço por Hora (R\$)',
                hint: 'Ex: 15.00',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (val) =>
                    val!.isEmpty ? 'Informe o valor por hora' : null,
              ),
              const SizedBox(height: 16),

              // Regras do Condomínio
              _buildTextField(
                controller: _rulesController,
                label: 'Regras do Condomínio e Observações',
                hint: 'Ex: Portaria 24h. Necessário apresentar CNH na guarita.',
                maxLines: 3,
                validator: (val) =>
                    val!.isEmpty ? 'Descreva as instruções de entrada' : null,
              ),
              const SizedBox(height: 16),

              // Switch de Não-Moradores
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                activeColor: AppColors.primaryBlue,
                title: const Text('Permite visitantes de fora do condomínio?',
                    style:
                        TextStyle(color: AppColors.textPrimary, fontSize: 14)),
                subtitle: const Text(
                    'Se desativado, apenas moradores do prédio poderão alugar.',
                    style: TextStyle(
                        color: AppColors.textSecondary, fontSize: 12)),
                value: _allowsExternalGuests,
                onChanged: (val) => setState(() => _allowsExternalGuests = val),
              ),
              const SizedBox(height: 24),

              CustomButton(
                text: 'Publicar Vaga',
                isLoading: _isLoading,
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChoiceCard(
      {required String title,
      required String subtitle,
      required bool isSelected,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: isSelected ? AppColors.primaryBlue : Colors.transparent,
              width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    color: isSelected
                        ? AppColors.primaryBlue
                        : AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 13)),
            const SizedBox(height: 4),
            Text(subtitle,
                style: const TextStyle(
                    color: AppColors.textSecondary, fontSize: 11)),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 13)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: _inputDecoration(hint: hint),
          validator: validator,
        ),
      ],
    );
  }

  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
      filled: true,
      fillColor: AppColors.cardSurface,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    );
  }
}
