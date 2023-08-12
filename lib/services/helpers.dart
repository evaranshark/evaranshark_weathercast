abstract class Helpers {
  static T constraintWidthValue<T>({
    required double constraintWidth,
    required List<(double, T)> values,
    required T defaultValue,
  }) {
    for (var (breakpoint, value) in values) {
      if (constraintWidth < breakpoint) {
        return value;
      }
    }
    return defaultValue;
  }
}
