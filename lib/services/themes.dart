import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

class LinkTextStyle extends ThemeExtension<LinkTextStyle> {
  MaterialStateTextStyle textStyle;
  LinkTextStyle({
    required this.textStyle,
  });

  @override
  LinkTextStyle copyWith({MaterialStateTextStyle? textStyle}) {
    return LinkTextStyle(
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  ThemeExtension<LinkTextStyle> lerp(
      covariant ThemeExtension<LinkTextStyle>? other, double t) {
    return this;
  }
}

abstract base class ThemeProvider {
  ThemeData get light;
  ThemeData get dark;
  ColorScheme get colorSchemeLight;
  ColorScheme get colorSchemeDark;
}

final class GPNTheme implements ThemeProvider {
  factory GPNTheme.initTheme() {
    return _instance ??= GPNTheme._();
  }

  late ThemeData _themeDataLight, _themeDataDark;

  @override
  ThemeData get light => _instance!._themeDataLight;

  @override
  ThemeData get dark => _instance!._themeDataDark;

  @override
  ColorScheme get colorSchemeLight => const ColorScheme.light(
        onSurface: Colors.black, // Snackbar background,
        onError: Colors.red,
        surface: Colors.white,
        onInverseSurface: Colors.white,
        inverseSurface: Colors.black,
        error: Colors.red,
        primary: AppColors.accent,
        outlineVariant: Colors.black,
      );

  @override
  ColorScheme get colorSchemeDark => ColorScheme.light(
        onSurface: Colors.white, // Snackbar background,
        onError: Colors.red,
        surface: Colors.white,
        onInverseSurface: Colors.white,
        inverseSurface: Colors.grey.shade800,
        error: Colors.red,
        primary: AppColors.accent,
        outlineVariant: Colors.white,
      );

  static GPNTheme? _instance;

  TextTheme _defaultTextTheme(ColorScheme scheme) => Typography.material2021(
        colorScheme: scheme,
        black: Typography.blackMountainView.copyWith(
          headlineLarge: GoogleFonts.ubuntu(
            //color: Colors.black,
            fontSize: 28,
            height: 32 / 28,
            fontWeight: FontWeight.w500,
          ),
          headlineMedium: GoogleFonts.ubuntu(
            //color: Colors.black,
            fontSize: 22,
            height: 28 / 22,
            fontWeight: FontWeight.w500,
          ),
          bodyLarge: GoogleFonts.roboto(
            //color: Colors.black,
            fontSize: 17,
            height: 24 / 17,
          ),
          bodyMedium: GoogleFonts.roboto(
            //color: Colors.black,
            fontSize: 15,
            height: 22 / 15,
          ),
          bodySmall: GoogleFonts.roboto(
            //color: Colors.black,
            fontSize: 13,
            height: 18 / 13,
          ),
          titleMedium: GoogleFonts.roboto(
            //color: Colors.black,
            fontSize: 17,
            height: 24 / 17,
          ),
          labelLarge: GoogleFonts.roboto(
            //color: Colors.black,
            fontSize: 17,
            height: 24 / 17,
          ),
          displayLarge: GoogleFonts.ubuntu(
            fontSize: 64,
            height: 72 / 64,
            fontWeight: FontWeight.w500,
          ),
        ),
      ).black;

  GPNTheme._() {
    _themeDataLight = _getTheme(colorSchemeLight);
    _themeDataDark = _getTheme(colorSchemeDark);
  }

  _getTheme(ColorScheme scheme) {
    return ThemeData(
      colorScheme: scheme,
      textTheme: _defaultTextTheme(scheme),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          padding:
              const MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.all(8.0)),
          shape: MaterialStateProperty.resolveWith<OutlinedBorder>((states) =>
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
          foregroundColor:
              MaterialStateColor.resolveWith((states) => Colors.white),
          textStyle: MaterialStateTextStyle.resolveWith(
              (states) => _defaultTextTheme(scheme).bodyLarge!),
          alignment: Alignment.center,
          minimumSize: const MaterialStatePropertyAll<Size>(Size(48, 48)),
          maximumSize:
              const MaterialStatePropertyAll<Size>(Size.fromHeight(60)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.stroke,
          ),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.stroke,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: AppColors.accent,
          ),
        ),
        labelStyle: _defaultTextTheme(scheme).bodyLarge!.copyWith(
              color: AppColors.greyText,
            ),
        floatingLabelStyle: _defaultTextTheme(scheme).bodyMedium!.copyWith(
              color: AppColors.greyText,
            ),
        suffixIconColor: AppColors.accent,
      ),
      // switchTheme: SwitchThemeData(
      //   thumbColor:
      //       MaterialStateColor.resolveWith((states) => AppColors.accent),
      //   trackColor: MaterialStateColor.resolveWith(
      //       (states) => AppColors.accent.withAlpha(100)),
      // ),
      iconTheme: IconThemeData(
        color: scheme.onSurface,
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: scheme.inverseSurface,
        textStyle: _defaultTextTheme(scheme).labelLarge!.copyWith(
              color: scheme.onInverseSurface,
            ),
      ),
      dividerColor: scheme.outlineVariant,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: scheme.inverseSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentTextStyle: _defaultTextTheme(scheme).bodyMedium!.copyWith(
              color: scheme.onInverseSurface,
            ),
      ),
    );
  }
}

final class EvaransharkTheme implements ThemeProvider {
  EvaransharkTheme._() {
    _themeData = EvaTheming.themeBase.copyWith(
      elevatedButtonTheme: EvaTheming.elevatedButtonTheme,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.textP,
      ),
      textTheme: EvaTheming.defaultTextTheme,
      dividerColor: AppColors.textLight,
      inputDecorationTheme: InputDecorationTheme(
          border: MaterialStateOutlineInputBorder.resolveWith((states) {
        var activeStates = [
          MaterialState.hovered,
          MaterialState.focused,
          MaterialState.selected,
          MaterialState.pressed
        ];
        InputBorder getBorder(Color color) {
          return OutlineInputBorder(
            borderSide: BorderSide(
              color: color,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10),
          );
        }

        if (states.contains(MaterialState.focused)) {
          return getBorder(AppColors.violetHard);
        }
        if (states.contains(MaterialState.error)) {
          return getBorder(AppColors.errorColor);
        }
        if (activeStates.any(states.contains)) {
          return getBorder(AppColors.violetHard);
        }

        return getBorder(AppColors.violetLight);
      }), labelStyle: MaterialStateTextStyle.resolveWith((states) {
        if (states.contains(MaterialState.hovered)) {
          return GoogleFonts.rubik(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.03,
            color: AppColors.textP,
          );
        }
        return GoogleFonts.rubik(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.03,
          color: AppColors.violetLight,
        );
      }), floatingLabelStyle: MaterialStateTextStyle.resolveWith((states) {
        if (states.contains(MaterialState.focused)) {
          return EvaTheming.defaultTextTheme.labelSmall!.copyWith(
            color: AppColors.violetLight,
          );
        }
        if (states.contains(MaterialState.error)) {
          return EvaTheming.defaultTextTheme.labelSmall!.copyWith(
            color: AppColors.textLight,
          );
        }
        if (states.contains(MaterialState.hovered)) {
          return EvaTheming.defaultTextTheme.labelSmall!.copyWith(
            color: AppColors.violetLight,
          );
        }
        return EvaTheming.defaultTextTheme.labelSmall!.copyWith(
          color: AppColors.violetLight,
        );
      }), suffixIconColor: MaterialStateColor.resolveWith((states) {
        var activeStates = [
          MaterialState.hovered,
          MaterialState.focused,
        ];
        if (activeStates.any(states.contains)) {
          return AppColors.violetHard;
        }
        return AppColors.violetLight;
      })),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColors.textP;
            }
            if (states.contains(MaterialState.hovered) ||
                states.contains(MaterialState.focused)) {
              return AppColors.linkHover;
            }
            return AppColors.link;
          }),
        ),
      ),
      extensions: [
        EvaTheming.defaultLinkStyle,
        EvaTheming.defaultMainButtonStyle,
        EvaTheming.defaultOmegaIconButtonTheme,
      ],
    );
  }

  factory EvaransharkTheme.initTheme() {
    return _instance ??= EvaransharkTheme._();
  }

  late ThemeData _themeData;

  @override
  ThemeData get light => _instance!._themeData;

  static EvaransharkTheme? _instance;

  @override
  ColorScheme get colorSchemeDark => throw UnimplementedError();

  @override
  ColorScheme get colorSchemeLight => throw UnimplementedError();

  @override
  ThemeData get dark => _instance!._themeData;
}

abstract class EvaTheming {
  static final themeBase = ThemeData.light(useMaterial3: true).copyWith(
    colorScheme: const ColorScheme.light(
      primary: Color.fromARGB(255, 170, 158, 255),
    ),
    textTheme: defaultTextTheme,
  );

  static final defaultTextTheme =
      ThemeData.light(useMaterial3: true).textTheme.copyWith(
            labelSmall: GoogleFonts.rubik(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              letterSpacing: 0.5,
            ),
            titleMedium: GoogleFonts.rubik(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
            ),
            displayMedium: GoogleFonts.rubik(
              fontWeight: FontWeight.w700,
            ),
            bodyMedium: GoogleFonts.rubik(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.textP,
            ),
          );

  static ElevatedButtonThemeData footerElevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateColor.resolveWith((states) {
        return Colors.white;
      }),
      foregroundColor: MaterialStateColor.resolveWith((states) {
        return AppColors.textH;
      }),
      shadowColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
      textStyle: MaterialStatePropertyAll(GoogleFonts.rubik(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.48,
      )),
      padding: const MaterialStatePropertyAll(
        EdgeInsets.symmetric(
          vertical: 13,
          horizontal: 9,
        ),
      ),
      minimumSize: const MaterialStatePropertyAll<Size>(Size(42, 42)),
      shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      visualDensity: VisualDensity.standard,
    ),
  );

  static ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return const Color.fromARGB(255, 240, 238, 255);
        }
        if (states.contains(MaterialState.hovered)) {
          return const Color.fromARGB(255, 134, 27, 192);
        }
        if (states.contains(MaterialState.pressed)) {
          return const Color.fromARGB(255, 160, 74, 207);
        }
        return const Color.fromARGB(255, 160, 74, 207);
      }),
      foregroundColor: MaterialStateColor.resolveWith((states) {
        return states.contains(MaterialState.disabled)
            ? AppColors.violetHard
            : Colors.white;
      }),
      shadowColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
      textStyle: MaterialStatePropertyAll(GoogleFonts.rubik(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.03,
      )),
      padding: const MaterialStatePropertyAll(
        EdgeInsets.symmetric(
          vertical: 13,
          horizontal: 35,
        ),
      ),
      minimumSize: const MaterialStatePropertyAll<Size>(Size(50, 50)),
      shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      visualDensity: VisualDensity.standard,
    ),
  );

  static LinkTextStyle defaultLinkStyle = LinkTextStyle(
    textStyle: MaterialStateTextStyle.resolveWith((states) {
      return GoogleFonts.rubik(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.03,
        color: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.textP;
          }
          if (states.contains(MaterialState.hovered) ||
              states.contains(MaterialState.focused)) {
            return AppColors.linkHover;
          }
          return AppColors.link;
        }).resolve(states),
      );
    }),
  );

  static LinkTextStyle defaultHeaderLinkStyle = LinkTextStyle(
    textStyle: MaterialStateTextStyle.resolveWith((states) {
      return GoogleFonts.rubik(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.02,
        color: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.textP;
          }
          if (states.contains(MaterialState.hovered) ||
              states.contains(MaterialState.focused)) {
            return AppColors.linkHover;
          }
          return AppColors.link;
        }).resolve(states),
      );
    }),
  );

  static PageBarItemStyle defaultMainButtonStyle =
      PageBarItemStyle(textStyle: MaterialStateTextStyle.resolveWith((states) {
    return GoogleFonts.rubik(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: (states.contains(MaterialState.hovered))
          ? AppColors.mainButton
          : AppColors.textH,
    );
  }), border: MaterialStateProperty.resolveWith((states) {
    if (states.contains(MaterialState.selected)) {
      return const Border(
        bottom: BorderSide(
          color: AppColors.mainButton,
          width: 2.0,
        ),
      );
    }
    return const Border.fromBorderSide(BorderSide.none);
  }));

  static OmegaIconButtonTheme defaultOmegaIconButtonTheme =
      OmegaIconButtonTheme(
    labelStyle: MaterialStateTextStyle.resolveWith((states) {
      return GoogleFonts.rubik(
        fontWeight: FontWeight.w500,
        fontSize: 12.0,
        color: AppColors.textH,
      );
    }),
  );
}

class PageBarItemStyle extends ThemeExtension<PageBarItemStyle> {
  final MaterialStateTextStyle textStyle;
  final MaterialStateProperty<Border> border;

  PageBarItemStyle({
    required this.textStyle,
    required this.border,
  });

  @override
  ThemeExtension<PageBarItemStyle> copyWith({
    MaterialStateTextStyle? textStyle,
    MaterialStateProperty<Border>? border,
  }) {
    return PageBarItemStyle(
      textStyle: textStyle ?? this.textStyle,
      border: border ?? this.border,
    );
  }

  @override
  ThemeExtension<PageBarItemStyle> lerp(
      covariant ThemeExtension<PageBarItemStyle>? other, double t) {
    return this;
  }
}

class OmegaIconButtonTheme extends ThemeExtension<OmegaIconButtonTheme> {
  final MaterialStateTextStyle labelStyle;

  OmegaIconButtonTheme({
    required this.labelStyle,
  });

  @override
  ThemeExtension<OmegaIconButtonTheme> copyWith() {
    return this;
  }

  @override
  ThemeExtension<OmegaIconButtonTheme> lerp(
      covariant ThemeExtension<OmegaIconButtonTheme>? other, double t) {
    return this;
  }
}
