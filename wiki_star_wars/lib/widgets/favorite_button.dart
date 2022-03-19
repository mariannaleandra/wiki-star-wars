import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onSelect;
  const FavoriteButton({
    Key? key,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return IconButton(
      icon: Icon(
        isSelected ? Icons.star : Icons.star_border,
      ),
      iconSize: theme.iconTheme.size,
      color: theme.iconTheme.color,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      onPressed: onSelect,
    );
  }
}
