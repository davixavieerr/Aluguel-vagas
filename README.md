# 🚗 Parking App — Plataforma P2P & B2C de Locação de Vagas

> Aplicativo mobile em **Flutter** para aluguel de vagas de garagem ociosas em condomínios residenciais (**P2P**) e estacionamentos rotativos (**B2C**), com foco inicial na região da **Avenida Paulista e Paraíso (São Paulo - SP)**.

---

## 📌 Visão Geral e Proposta de Valor

Muitos moradores de condomínios possuem vagas de garagem ociosas (ex: famílias com duas vagas que utilizam apenas uma, ou moradores sem veículo). Ao mesmo tempo, motoristas e trabalhadores enfrentam escassez de vagas e altos custos em estacionamentos tradicionais.

O **Parking App** resolve essa dor conectando moradores a locatários através de **Contratos Mensais Recorrentes** e **Locações Flexíveis**, com segurança garantida para as portarias e condomínios (*Trust & Safety*).

---

## ✨ Funcionalidades Implementadas

### 🗺️ 1. Mapa Interativo & Status de Vagas (Estilo Uber / Airbnb)

<p align="center">
  <img src="images/Readme_1.png" alt="Mapa interativo com pins de vagas na Av. Paulista" width="70%"/>
</p>

- **Tema Escuro Moderno (*Dark Map*):** Estilização customizada em JSON destacando o traçado urbano e os marcadores de vagas.
- **Semáforo de Disponibilidade:**
  - 🟢 **Verde:** Vaga disponível / Contrato mensal livre.
  - 🟡 **Amarelo:** Poucas vagas restantes (1 a 3 vagas).
  - 🔴 **Vermelho:** Vaga ocupada / Prédio lotado.
- **Filtros Rápidos em Tempo Real:** Filtragem por `Contrato Mensal`, `Por Hora`, `Residencial (P2P)` e `Apenas Disponíveis`.
- **Animação Fluida de Câmera:** Centralização e zoom suave ao selecionar qualquer ponto no mapa.

### 🏢 2. Modalidade de Contrato Mensal P2P & Rotativo
- Suporte a contratos mensais fixos com duração configurável (1, 3, 6 ou 12 meses).
- Especificação de regras de condomínio (ex: *Permite visitantes externos* vs *Apenas moradores do prédio*).
- Indicação do método de entrada: **QR Code digital**, **Controle remoto / Tag** ou **Liberação prévia na Portaria**.
- Suporte a diferentes portes de veículos: Compacto, Sedan, SUV e Motocicleta.

### 🔔 3. Sistema de Fila de Espera (*Waitlist / Alertas*)
- Possibilidade de ativar alerta para prédios com status **Vermelho (Ocupado)**.
- Tela de gerenciamento de alertas ativos para cancelamento ou acompanhamento.

### ➕ 4. Anúncio de Vaga & Seletor de Ponto no Mapa
- **Formulário de Cadastro Completo (`AddSpotScreen`):** Moradores anunciam suas vagas definindo preço mensal, tempo mínimo de contrato, regras e método de acesso.
- **Geocodificação Inteligente & Seletor Visual (`LocationPickerScreen`):** Identificação de endereços reais e seletor com pino arrastável para marcar a entrada exata da garagem.
- **Gestão de Vagas Anunciadas (`MySpotsScreen`):** Painel do anfitrião para monitorar e excluir anúncios.

### 💳 5. Fluxo de Reserva & Check-in Digital
- **Checkout Dinâmico (`BookingCheckoutScreen`):** Cálculo automático de valores por meses ou horas e seleção de forma de pagamento (Pix / Cartão).
- **Passe Digital QR Code (`QRCodeCheckinScreen`):** Geração de comprovante de check-in para apresentação na portaria com horário de validade.

### 💬 6. Chat Integrado com a Portaria / Anfitrião
- Mensageria instantânea para troca de instruções de portaria, placas de veículos e entrega de controle remoto.

### 👤 7. Perfil de Usuário & Confiança (*Trust & Safety*)

<p align="center">
  <img src="images/Readme_2.png" alt="Tela de perfil do usuário com avaliação e verificação" width="45%"/>
</p>

- Avaliação mútua com estrelas e histórico de locações.
- Selo de verificação de identidade / CNH.
- Alternância rápida entre **Modo Motorista (Locatário)** e **Modo Anfitrião (Locador)**.

---

## 🏗️ Arquitetura do Projeto

O projeto adota uma arquitetura modular baseada em funcionalidades (**Feature-First**):

```text
lib/
├── core/
│   ├── constants/
│   │   └── map_style.dart           # Estilização JSON do mapa escuro (Dark Mode)
│   ├── theme/
│   │   └── app_colors.dart          # Cores e design system do aplicativo
│   └── utils/
│       └── formatters.dart          # Formatadores de Moeda (R$), Distâncias e Datas
├── features/
│   ├── auth/
│   │   └── presentation/
│   │       └── profile_screen.dart  # Perfil do usuário e Trust & Safety
│   ├── booking/
│   │   └── presentation/
│   │       ├── booking_checkout_screen.dart # Checkout e cálculo de contrato
│   │       ├── my_bookings_screen.dart      # Listagem de reservas ativas
│   │       └── qr_code_checkin_screen.dart  # Passe digital com QR Code
│   ├── chat/
│   │   └── presentation/
│   │       └── chat_screen.dart     # Chat entre anfitrião e motorista
│   ├── map/
│   │   └── presentation/
│   │       ├── main_shell_screen.dart # Shell principal com BottomNavigationBar
│   │       ├── map_home_screen.dart   # Tela principal do mapa interativo
│   │       └── widgets/
│   │           ├── map_filter_chips.dart # Chips de filtragem rápida
│   │           ├── map_search_bar.dart   # Barra de busca flutuante
│   │           └── spot_details_card.dart # Card flutuante da vaga selecionada
│   ├── spots/
│   │   ├── data/
│   │   │   └── spots_repository.dart # Repositório reativo singleton (State Management)
│   │   └── presentation/
│   │       ├── add_spot_screen.dart         # Formulário de anúncio de vagas
│   │       ├── location_picker_screen.dart  # Seletor visual de ponto no mapa
│   │       ├── my_spots_screen.dart         # Painel de vagas do anfitrião
│   │       └── spot_details_screen.dart     # Detalhes e termos da vaga
│   └── waitlist/
│       └── presentation/
│           └── my_waitlists_screen.dart     # Gerenciamento de alertas ativos
├── shared/
│   ├── models/
│   │   ├── booking_model.dart       # Modelo de Reservas e Pagamentos
│   │   ├── chat_message_model.dart  # Modelo de Mensagens do Chat
│   │   ├── parking_spot_model.dart  # Modelo de Vagas e Contratos
│   │   └── user_model.dart          # Modelo de Usuários e Reputação
│   └── widgets/
│       └── custom_button.dart       # Botão padrão reutilizável
└── main.dart                        # Ponto de entrada do aplicativo
```

---

## 🛠️ Stack Tecnológica

- **Framework:** Flutter (Dart 3)
- **Mapas e Geolocalização:** `google_maps_flutter`
- **Requisições e Geocodificação:** `http`
- **Ícones e Design:** `cupertino_icons` & `Material Icons`
- **Gerenciamento de Estado:** `ChangeNotifier` / `ListenableBuilder` *(com arquitetura pronta para migração para Riverpod/Bloc)*

---

## 🚀 Como Executar o Projeto

### Pré-requisitos
- Flutter SDK instalado (versão >= 3.0.0)
- Dispositivo Android (Emulador ou Físico), Simulador iOS ou Navegador Chrome/Edge

### Instalação

1. **Clone o repositório:**
```bash
git clone https://github.com/seu-usuario/parking_app.git
cd parking_app
```

2. **Instale as dependências:**
```bash
flutter pub get
```

3. **Configure a Google Maps API Key:**
- **Android:** Insira sua chave no arquivo `android/app/src/main/AndroidManifest.xml`:
```xml
<meta-data 
    android:name="com.google.android.geo.API_KEY"
    android:value="SUA_CHAVE_API_AQUI"/>
```
- **Web:** Insira o script no `<head>` do arquivo `web/index.html`:
```html
<script src="https://maps.googleapis.com/maps/api/js?key=SUA_CHAVE_API_AQUI"></script>
```

4. **Execute a aplicação:**
```bash
flutter run
```

---

## 🗺️ Prédios e Vagas Mockadas para Teste (Região da Paulista)

| Edifício / Estacionamento | Endereço | Modalidade | Valor | Status |
| :--- | :--- | :--- | :--- | :--- |
| **Edifício Barão de Capanema** | Al. Santos, 1893 | Contrato Mensal (P2P) | R$ 420,00/mês | 🟢 Livre |
| **Edifício Residencial Anchieta** | Av. Paulista, 2584 | Contrato Mensal (P2P) | R$ 380,00/mês | 🟢 Livre |
| **Estacionamento Top Center** | Av. Paulista, 854 | Mensal / Rotativo (B2C) | R$ 22,00/h ou R$ 650/mês | 🟢 3 vagas |
| **Condomínio Parque Paulista** | Rua Cincinato Braga, 450 | Contrato Mensal (P2P) | R$ 350,00/mês | 🔴 Lotado (Waitlist) |
| **Edifício Paulista Tower** | Al. Santos, 1470 | Rotativo (P2P) | R$ 14,00/h | - |

---

## 👥 Equipe

| Integrante | Responsabilidade |
| :--- | :--- |
| **Gabriel Simioni** | Construção da seção de Perfil (telas de Métodos de Pagamento, Segurança e Documentos, Suporte e Ajuda) e documentação do README |
| **Davi** | Desenvolvedor do sistema — arquitetura do app e conexão com API |


