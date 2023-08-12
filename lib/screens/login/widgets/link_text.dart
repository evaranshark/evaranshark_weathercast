import 'package:flutter/material.dart';

import '../../../services/themes.dart';

class LinkText extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final int? maxLines;
  const LinkText({
    super.key,
    required this.text,
    this.onPressed,
    this.maxLines = 1,
  });

  @override
  State<LinkText> createState() => _LinkTextState();
}

class _LinkTextState extends State<LinkText> with MaterialStateMixin {
  @override
  Widget build(BuildContext context) {
    setMaterialState(MaterialState.disabled, widget.onPressed == null);
    return InkWell(
      hoverColor: Colors.transparent,
      onTap: widget.onPressed,
      onHover: updateMaterialState(MaterialState.hovered),
      child: Text(
        widget.text,
        maxLines: widget.maxLines,
        style: Theme.of(context)
            .extension<LinkTextStyle>()!
            .textStyle
            .resolve(materialStates),
        // style: Theme.of(context).extension<LinkTextStyle>()!.style.copyWith(
        //     color: Theme.of(context)
        //         .extension<LinkTextStyle>()!
        //         .color
        //         .resolve(materialStates)),
      ),
    );
  }
}
