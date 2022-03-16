import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final double size;
  const LoadingWidget({Key? key, this.size = 50}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Center(
      child: Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(5),
        child: CircularProgressIndicator(
          backgroundColor: theme.backgroundColor,
          value: null,
          valueColor: AlwaysStoppedAnimation<Color>(
            theme.primaryColor,
          ),
          strokeWidth: size / 10,
        ),
      ),
    );
  }
}
