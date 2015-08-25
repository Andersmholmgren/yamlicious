// Copyright (c) 2015, Anders Holmgren. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library yamlicious.example;

import 'dart:io' show File;

import 'package:yaml/yaml.dart' show loadYaml;
import 'package:yamlicious/yamlicious.dart' show toYamlString;

main() {
  File file = new File("pubspec.yaml");
  print(toYamlString(loadYaml(file.readAsStringSync())));
}
