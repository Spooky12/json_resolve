# json resolver

- Available at <https://pub.dev/packages/json_resolver>
- Based on [json_resolve by Khoa Pham](https://github.com/onmyway133/json_resolve)
- [How to resolve deep json object in Dart](https://dev.to/onmyway133/how-to-resolve-deep-json-object-in-dart-5c5l)

## Description

json_resolver is a Dart library that helps accessing property in deep json object easily using keypath.

Given the following deeply nested json:

```json
{
    "movie": "isFun",
    "earth": 199999,
    "dc": [
      {"name": "Superman"},
      {"name": "Flash"},
      {"name": "Wonder Woman"}
    ],
    "marvel": [
      {
        "name": "Thor",
        "weapon": "Mjolnir",
        "appear": [
          {"year": 2011, "title": "Thor"},
          {"year": 2013, "title": "The Dark World"},
          {"year": 2017, "title": "Ragnarok"}
        ]
      }
    ]
  }
```

We can access using keypath. The library ensures safe type checking and casting. You can provide default value to ensure that return value is not null (if you provide default value you may use bang operator `!` to to cast the return to a non null value).

```dart
final String? byPropertyNullable = resolve(json: json, path: "movie");
expect(byPropertyNullable, "isFun");

final String byProperty = resolve(json: json, path: "movie", defaultValue: "error")!;
expect(byProperty, "isFun");

final int byInt = resolve(json: json, path: "earth", defaultValue: 0)!;
expect(byInt, 199999);

final String byIndex = resolve(json: json, path: "dc.2.name", defaultValue: "error")!;
expect(byIndex, "Wonder Woman");

final String byIndexThenProperty = resolve(json: json, path: "marvel.0.appear.1.title", defaultValue: "error")!;
expect(byIndexThenProperty, "The Dark World");

final int? byIntNullable = resolve(json: json, path: "movie");
expect(byIntNullable, null);

final int byInt = resolve(json: json, path: "movie", defaultValue: 0)!;
expect(byInt, 0);
```

## Installation

First of all add the following dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  json_resolver: ^2.0.0
```

## License

**json_resolver** is available under the MIT license. See the [LICENSE](https://github.com/Spooky12/json_resolve/blob/master/LICENSE) file for more info.
