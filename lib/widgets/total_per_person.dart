import 'package:flutter/material.dart';

class TotalPerPerson extends StatelessWidget {
  const TotalPerPerson({
    super.key,
    required this.style,
    required this.total,
    required this.theme,
  });

  final TextStyle style;
  final double total;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Text(
              'Total Per Person',
              style: style,
            ),
            Text(
              '\$${total.toStringAsFixed(2)}',
              style: style.copyWith(
                color: theme.colorScheme.onPrimary,
                fontSize: theme.textTheme.displaySmall?.fontSize,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
