import 'package:flutter/material.dart';
import 'package:dbp_project/components/NavigationBar.dart';
import 'package:dbp_project/dashboard/dashboard_content.dart';
import 'package:dbp_project/drivers/drivers_content.dart';
import 'package:dbp_project/vehicles/vehicles_content.dart';
import 'package:dbp_project/alerts/alerts_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<String> _titles = [
    "Dashboard",
    "Drivers",
    "Vehicles",
    "Alerts",
    "Settings",
  ];

  final List<String> _subtitles = [
    "Sistema Operativo",
    "Manage and monitor all drivers",
    "Monitor all connected vehicles",
    "System generated events",
    "Application settings",
  ];

  Widget _getBodyContent() {
    switch (_currentIndex) {
      case 0:
        return const DashboardContent();
      case 1:
        return const DriversContent();
      case 2:
        return const VehiclesContent();
      case 3:
        return const AlertsContent();
      default:
        return const Center(
          child: Text("Settings", style: TextStyle(color: Colors.white)),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool showLogo = _currentIndex == 0;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color(0xFF121212),
        titleSpacing: 16,
        title: Row(
          children: [
            if (showLogo) ...[
              Image.asset(
                "assets/images/safe_driving.png",
                width: 42,
                height: 42,
              ),
              const SizedBox(width: 12),
            ],
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _titles[_currentIndex],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  _subtitles[_currentIndex],
                  style: const TextStyle(fontSize: 11, color: Colors.white60),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_none_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEF4444),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      "3",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _getBodyContent()),
          Navigationbar(
            currentIndex: _currentIndex,
            onTabSelected: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ],
      ),
    );
  }
}
