import 'dart:typed_data';

import 'package:base85/base85.dart';
import 'package:test/test.dart';

void main() {
  group('z85', () {
    var z85 = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRST' //
        'UVWXYZ.-:+=^!/*?&<>()[]{}@%\$#';
    var codec = Base85Codec(z85);
    test('z85 encode', () {
      expect(
        'nm=QNz.92Pz/PV8',
        codec.encode(Uint8List.fromList('Hello, world'.codeUnits)),
      );
    });

    test('z85 decode', () {
      expect(
        'Hello, world!!!!',
        String.fromCharCodes(codec.decode('nm=QNz.92Pz/PV8aT50L')),
      );
    });
  });

  group('ascii85', () {
    var ascii85 = '!"#\$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVW' //
        'XYZ[\\]^_`abcdefghijklmnopqrstu';
    var codec = Base85Codec(ascii85);
    test('ascii85 encode', () {
      expect(
        '87cURD_*#TDfTZ)',
        codec.encode(Uint8List.fromList('Hello, world'.codeUnits)),
      );
    });

    test('ascii85 decode', () {
      expect(
        'Hello, world',
        String.fromCharCodes(codec.decode('87cURD_*#TDfTZ)')),
      );
    });
  });
}
