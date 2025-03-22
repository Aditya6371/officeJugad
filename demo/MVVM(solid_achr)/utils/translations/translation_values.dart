import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'translation_keys.dart';

part 'translation_en.dart';
part 'translation_nl.dart';

class TranslationsFile extends Translations {
  /// List of locales used in the application
  static const listOfLocales = <Locale>[
    Locale('en'),
    Locale('nl'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'nl': nl,
      };
}
