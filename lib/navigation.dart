import 'package:financial_record/Views/home.dart';
import 'package:financial_record/Views/laporan.dart';
import 'package:financial_record/Views/setting.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key,});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final List _pages = [
    const Home(),
    // const Laporan(),
    const Setting(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: GNav(
          backgroundColor: Colors.grey.shade800,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade800,
          padding: const EdgeInsets.all(16),
          gap: 8,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Beranda',
            ),
            // GButton(
            //   icon: Icons.receipt_long,
            //   text: 'Laporan',
            // ),
            GButton(
              icon: Icons.settings,
              text: 'Pengaturan',
            ),
          ],
        ),
      ),
      body: _pages.elementAt(_selectedIndex),
    );
  }
}
