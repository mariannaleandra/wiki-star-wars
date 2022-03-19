import 'package:flutter/material.dart';
import 'package:wiki_star_wars/widgets/loading.dart';

class Field extends StatelessWidget {
  final String label;
  final String text;
  final IconData? icon;
  final Color? color;
  final bool loadingData;
  final String loadingMsg;
  const Field({
    Key? key,
    required this.text,
    required this.label,
    this.icon,
    this.color,
    this.loadingData = false,
    this.loadingMsg = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        border: Border.all(
          color: color ?? theme.primaryColor,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(
        5.0,
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        loadingData
            ? LoadingWidget(
                size: theme.iconTheme.size!,
                color: color,
              )
            : Icon(
                icon,
                color: color ?? theme.primaryColor,
                size: theme.iconTheme.size,
              ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: theme.textTheme.headline3?.apply(
                color: color ?? theme.primaryColor,
                fontWeightDelta: 7,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              loadingData ? loadingMsg : text,
              style: theme.textTheme.headline2?.apply(
                color: color ?? theme.primaryColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        )
      ]),
    );
  }
}
