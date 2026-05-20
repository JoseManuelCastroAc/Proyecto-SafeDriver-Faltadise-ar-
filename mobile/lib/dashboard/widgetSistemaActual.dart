import 'package:flutter/material.dart';

class WidgetSistemaActual extends StatelessWidget {
  final int driversCount;
  final int vehiclesCount;
  final int alertsCount;
  final String systemStatus;

  const WidgetSistemaActual({
    super.key,
    required this.driversCount,
    required this.vehiclesCount,
    required this.alertsCount,
    required this.systemStatus,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCritical = systemStatus.toUpperCase() == 'CRITICAL';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.35,
        children: [
          _buildMetricCard(
            title: 'Drivers',
            value: driversCount.toString(),
            icon: Icons.people,
            color: Colors.blueAccent,
          ),
          _buildMetricCard(
            title: 'Vehicles',
            value: vehiclesCount.toString(),
            icon: Icons.directions_car,
            color: Colors.greenAccent,
          ),
          _buildMetricCard(
            title: 'Alerts',
            value: alertsCount.toString(),
            icon: Icons.warning_amber_rounded,
            color: Colors.orangeAccent,
          ),
          _buildMetricCard(
            title: 'System',
            value: systemStatus,
            icon: isCritical
                ? Icons.error_outline
                : Icons.check_circle_outline,
            color: isCritical
                ? Colors.redAccent
                : Colors.greenAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF161A1F),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: color.withOpacity(0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: color,
            size: 26,
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}