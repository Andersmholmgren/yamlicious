// Copyright (c) 2015, Anders Holmgren. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library yamlicious.test;

import 'package:yaml/yaml.dart';
import 'package:yamlicious/yamlicious.dart';
import 'package:test/test.dart';
import 'dart:io';

main() {

  group("", () {
    test("", () {
      var v = loadYaml(new File("test/example.yaml").readAsStringSync());
      var s = toYamlString(v);
      var v2 = loadYaml(s);
      expect(v,v2);

    });
  });
}
