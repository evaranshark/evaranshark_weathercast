import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repositories/style_repo.dart';

class ChangeThemeWidget extends StatelessWidget {
  const ChangeThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StyleRepo>(
      builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Альтернативная тема",
            ),
            Switch.adaptive(
              value: !value.useGPNTheme,
              onChanged: (switchValue) => value.changeTheme(!switchValue),
            ),
          ],
        );
      },
    );
  }
}
