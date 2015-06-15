// Copyright (c) 2015, Anders Holmgren. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library yaml.writer;

import 'package:quiver/iterables.dart';

/// Serialises [node] into a String and returns it
String toYamlString(node) {
  var sb = new StringBuffer();
  writeYamlString(node, sb);
  return sb.toString();
}

/// Serialises [node] into a String and writes it to the [sink]
void writeYamlString(node, StringSink sink) {
  _writeYamlString(node, 0, sink, true);
}

_writeYamlString(node, int indent, StringSink ss, bool isTopLevel) {
  if (node is Map) {
    _mapToYamlString(node, indent, ss, isTopLevel);
  } else if (node is Iterable) {
    _listToYamlString(node, indent, ss, isTopLevel);
  } else {
    ss..writeln(node);
  }
}

_mapToYamlString(Map node, int indent, StringSink ss, bool isTopLevel) {
  if (!isTopLevel) {
    ss.writeln();
    indent += 2;
  }

  final keys = _sortKeys(node);

  keys.forEach((k) {
    final v = node[k];
    _writeIndent(indent, ss);
    ss..write(k)..write(': ');
    _writeYamlString(v, indent, ss, false);
  });
}

Iterable<String> _sortKeys(Map m) {
  final simple = [];
  final maps = [];
  final other = [];

  m.forEach((k, v) {
    if (v is String) {
      simple.add(k);
    } else if (v is Map) {
      maps.add(k);
    } else {
      other.add(k);
    }
  });

  return concat([simple..sort(), maps..sort(), other..sort()]);
}

_listToYamlString(Iterable node, int indent, StringSink ss, bool isTopLevel) {
  if (!isTopLevel) {
    ss.writeln();
    indent += 2;
  }

  node.forEach((v) {
    _writeIndent(indent, ss);
    ss.write('- ');
    _writeYamlString(v, indent, ss, false);
  });
}

void _writeIndent(int indent, StringSink ss) {
  for (int i = 0; i < indent; i++) {
    ss.write(' ');
  }
}
