//
// json_resolve
// Created by Khoa Pham
// Updated by SpooKy12
//

/// Resolve nested JSON property from provided [json] into
/// [T?] object using [path].
///
/// If [defaultValue] is provided, it will return it if [path]
/// doesn't exist in [json] or an error is raised.
/// With a [defaultValue] set to non-null value, you may use the
/// bang operator (!) to cast the return value back to [T].
///
/// Example:
/// ```dart
/// final String? prop = resolve<String>(json: json, path: 'movie');
/// ```
///
/// Example with default value:
/// ```dart
/// final String? prop =
///     resolve<String>(json: json, path: 'movie', defaultValue: 'error')!;
/// ```
T? resolve<T>({
  required Map<String, dynamic>? json,
  required String path,
  T? defaultValue,
}) {
  try {
    if (json == null) {
      return defaultValue;
    }
    dynamic current = json;
    path.split('.').forEach((segment) {
      final maybeInt = int.tryParse(segment);

      if (maybeInt != null && current is List<dynamic>) {
        current = current[maybeInt];
      } else if (current is Map<String, dynamic>) {
        current = current[segment];
      }
    });

    return (current as T?) ?? defaultValue;
  } catch (error) {
    print(error);
    return defaultValue;
  }
}
