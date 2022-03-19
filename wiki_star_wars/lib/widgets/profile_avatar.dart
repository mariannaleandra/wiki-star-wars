import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String? name;
  final Color? bgColor;
  const ProfileAvatar({Key? key, this.name = '', this.bgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: theme.backgroundColor, width: 2.0),
          ),
          child: CircleAvatar(
            backgroundColor: bgColor,
            backgroundImage: const AssetImage('assets/images/helmet.png'),
          ),
        ),
        const SizedBox(height: 10),
        if (name!.isNotEmpty)
          Text(
            name!,
            style: theme.textTheme.headline2?.apply(
              color: theme.backgroundColor,
              fontWeightDelta: 7,
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}
