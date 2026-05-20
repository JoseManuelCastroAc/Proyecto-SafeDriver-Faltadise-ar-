import 'package:flutter/material.dart';

class AlertacriticaDashboard extends StatelessWidget {
  final String driverName;
  final String alertDescription;
  final bool hasCriticalAlert;

  const AlertacriticaDashboard({
    super.key,
    required this.driverName,
    required this.alertDescription,
    required this.hasCriticalAlert,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = hasCriticalAlert
        ? Colors.redAccent.withOpacity(0.8)
        : Colors.greenAccent.withOpacity(0.6);

    final shadowColor = hasCriticalAlert
        ? Colors.redAccent.withOpacity(0.1)
        : Colors.greenAccent.withOpacity(0.08);

    final iconBackgroundColor = hasCriticalAlert
        ? Colors.redAccent.withOpacity(0.2)
        : Colors.greenAccent.withOpacity(0.15);

    final iconColor = hasCriticalAlert ? Colors.redAccent : Colors.greenAccent;

    final title = hasCriticalAlert
        ? 'ALERTA CRÍTICA'
        : 'SISTEMA EN ESTADO NORMAL';

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                hasCriticalAlert
                    ? Icons.warning_amber_rounded
                    : Icons.check_circle_outline,
                color: iconColor,
                size: 30,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: iconColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Conductor: $driverName',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    alertDescription,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
