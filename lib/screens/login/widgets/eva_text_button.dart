import 'package:flutter/material.dart';

class EvaTextButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  const EvaTextButton._({
    super.key,
    required this.underlined,
    this.onPressed,
    required this.child,
  });

  factory EvaTextButton({
    Key? key,
    required Widget child,
    required VoidCallback onPressed,
  }) =>
      EvaTextButton._(
        key: key,
        underlined: false,
        onPressed: onPressed,
        child: child,
      );

  factory EvaTextButton.underlined({
    Key? key,
    required VoidCallback onPressed,
    required Widget child,
  }) {
    return EvaTextButton._(
      key: key,
      underlined: true,
      onPressed: onPressed,
      child: child,
    );
  }

  final bool underlined;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              decoration: null, //underlined ? TextDecoration.underline : null,
            ),
      ),
      child: child,
    );
  }
}
