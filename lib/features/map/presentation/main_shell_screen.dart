// Caminho: lib/features/map/presentation/main_shell_screen.dart

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/presentation/profile_screen.dart';
import '../../booking/presentation/my_bookings_screen.dart';
import '../../spots/presentation/add_spot_screen.dart';
import '../../spots/presentation/my_spots_screen.dart';
import '../../waitlist/presentation/my_waitlists_screen.dart';
import 'map_home_screen.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      const MapHomeScreen(),
      const MyBookingsScreen(),
      const MyWaitlistsScreen(),
      AddSpotScreen(
        onSpotAdded: () {
          setState(() => _currentIndex = 0); // Vai para o Mapa ao publicar
        },
      ),
      const MySpotsScreen(), // Minhas Vagas Anunciadas
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white10, width: 0.5)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: AppColors.cardSurface,
          selectedItemColor: AppColors.primaryBlue,
          unselectedItemColor: AppColors.textSecondary,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined),
              activeIcon: Icon(Icons.map),
              label: 'Mapa',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              activeIcon: Icon(Icons.calendar_today),
              label: 'Reservas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none_rounded),
              activeIcon: Icon(Icons.notifications_rounded),
              label: 'Alertas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              activeIcon: Icon(Icons.add_circle),
              label: 'Anunciar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.garage_outlined),
              activeIcon: Icon(Icons.garage),
              label: 'Minhas Vagas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}
