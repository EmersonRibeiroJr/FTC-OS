import 'package:flutter/material.dart';
import 'package:ftc_os/shared/design_system/tokens.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({required this.title, required this.body, this.icon = Icons.inbox_outlined, super.key});
  final String title;
  final String body;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Space.xxl),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 48, color: t.colorScheme.outline),
          const SizedBox(height: Space.lg),
          Text(title, style: t.textTheme.titleMedium, textAlign: TextAlign.center),
          const SizedBox(height: Space.sm),
          Text(body, style: t.textTheme.bodyMedium, textAlign: TextAlign.center),
        ],),
      ),
    );
  }
}
