import 'package:flutter/material.dart';
import 'package:dbp_project/components/navigationbarwidgets.dart';

class Navigationbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const Navigationbar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF161A1F),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: Colors.white.withOpacity(0.04)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Navigationbarwidgets(
            icon: Icons.home_filled,
            label: 'Dashboard',
            isSelected: currentIndex == 0,
            onTap: () => onTabSelected(0),
          ),
          Navigationbarwidgets(
            icon: Icons.people_alt_rounded,
            label: 'Drivers',
            isSelected: currentIndex == 1,
            onTap: () => onTabSelected(1),
          ),
          Navigationbarwidgets(
            icon: Icons.local_shipping_rounded,
            label: 'Vehicles',
            isSelected: currentIndex == 2,
            onTap: () => onTabSelected(2),
          ),
          Navigationbarwidgets(
            icon: Icons.notifications_rounded,
            label: 'Alerts',
            isSelected: currentIndex == 3,
            badgeCount: 3,
            onTap: () => onTabSelected(3),
          ),
          Navigationbarwidgets(
            icon: Icons.settings_rounded,
            label: 'Settings',
            isSelected: currentIndex == 4,
            onTap: () => onTabSelected(4),
          ),
        ],
      ),
    );
  }
}
