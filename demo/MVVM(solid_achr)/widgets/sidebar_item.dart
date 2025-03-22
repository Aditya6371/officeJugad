import 'package:flutter/material.dart';
import 'package:zero_admin/res/res.dart';

class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback? onTap;
  final List<SidebarSubItem>? subItems;
  final bool isExpanded;
  final Function(bool)? onExpansionChanged;

  const SidebarItem({
    super.key,
    required this.icon,
    required this.title,
    this.isSelected = false,
    this.onTap,
    this.subItems,
    this.isExpanded = false,
    this.onExpansionChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (subItems == null || subItems!.isEmpty) {
      return buildSimpleItem();
    }
    return buildExpansionItem();
  }

  Widget buildSimpleItem() {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: Dimens.edgeInsets12,
        margin: Dimens.edgeInsets0_4,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.1) : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
            Dimens.boxWidth8,
            Text(
              title,
              style: Styles.white12.copyWith(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildExpansionItem() {
    return Theme(
      data: ThemeData(
        dividerColor: Colors.transparent,
        expansionTileTheme: const ExpansionTileThemeData(
          backgroundColor: ColorsValue.primaryColor,
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
        ),
      ),
      child: ExpansionTile(
        initiallyExpanded: isExpanded,
        onExpansionChanged: onExpansionChanged,
        leading: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        title: Text(
          title,
          style: Styles.white12.copyWith(
            fontSize: 12,
          ),
        ),
        backgroundColor: Colors.transparent,
        collapsedBackgroundColor: Colors.transparent,
        childrenPadding: const EdgeInsets.only(left: 16),
        children: subItems!.map((item) => item).toList(),
      ),
    );
  }
}

class SidebarSubItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const SidebarSubItem({
    super.key,
    required this.title,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.1) : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: Styles.white12.copyWith(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
