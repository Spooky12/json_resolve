//
// json_resolve
// Created by Khoa Pham
// Updated by SpooKy12
//

import 'package:test/test.dart';
import 'package:json_resolve/json_resolve.dart';

void main() {
  const json = {
    'movie': 'isFun',
    'earth': 199999,
    'dc': [
      {'name': 'Superman'},
      {'name': 'Flash'},
      {'name': 'Wonder Woman'}
    ],
    'marvel': [
      {
        'name': 'Thor',
        'weapon': 'Mjolnir',
        'appear': [
          {'year': 2011, 'title': 'Thor'},
          {'year': 2013, 'title': 'The Dark World'},
          {'year': 2017, 'title': 'Ragnarok'}
        ]
      }
    ]
  };

  test('resolve', () {
    final byProperty =
        resolve<String>(json: json, path: 'movie', defaultValue: 'error')!;
    final byPropertyNullable = resolve<String>(json: json, path: 'movie');
    expect(byProperty, 'isFun');
    expect(byPropertyNullable, 'isFun');

    final byInt = resolve<int>(json: json, path: 'earth', defaultValue: 0)!;
    final byIntNullable =
        resolve<int>(json: json, path: 'earth', defaultValue: 0);
    expect(byInt, 199999);
    expect(byIntNullable, 199999);

    final byIndex =
        resolve<String>(json: json, path: 'dc.2.name', defaultValue: 'error')!;
    final byIndexNullable = resolve<String>(json: json, path: 'dc.2.name');
    expect(byIndex, 'Wonder Woman');
    expect(byIndexNullable, 'Wonder Woman');

    final byIndexThenProperty = resolve<String>(
        json: json, path: 'marvel.0.appear.1.title', defaultValue: 'error')!;
    final byIndexThenPropertyNullable =
        resolve<String>(json: json, path: 'marvel.0.appear.1.title');
    expect(byIndexThenProperty, 'The Dark World');
    expect(byIndexThenPropertyNullable, 'The Dark World');
  });

  test('wrong type', () {
    final byInt =
        resolve<int>(json: json, path: 'marvel.0.name', defaultValue: 999)!;
    final byIntNullable = resolve<int>(json: json, path: 'marvel.0.name');
    expect(byInt, 999);
    expect(byIntNullable, null);
  });

  test('not found', () {
    final byString = resolve<String>(
        json: json, path: 'marvel.0.skill', defaultValue: 'error')!;
    final byStringNullable =
        resolve<String>(json: json, path: 'marvel.0.skill');
    expect(byString, 'error');
    expect(byStringNullable, null);
  });
}
