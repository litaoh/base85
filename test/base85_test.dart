import 'dart:io';
import 'dart:typed_data';

import 'package:base85/base85.dart';
import 'package:test/test.dart';

void main() {
  group('z85', () {
//    var z85 = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRST' //
//        'UVWXYZ.-:+=^!/*?&<>()[]{}@%\$#';
    var codec = Base85Codec(Alphabets.z85);
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
//    var ascii85 = '!"#\$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVW' //
//        'XYZ[\\]^_`abcdefghijklmnopqrstu';
    var codec = Base85Codec(Alphabets.ascii85, AlgoType.ascii85);
    test('ascii85 encode', () {
      expect(
        '<~87cURD_*#TDfTZ)~>',
        codec.encode(Uint8List.fromList('Hello, world'.codeUnits)),
      );
    });

    test('ascii85 decode', () {
      expect(
        'Hello, world',
        String.fromCharCodes(codec.decode('<~87cURD_*#TDfTZ)~>')),
      );
    });
  });

  group('IPv6', () {
    var codec = Base85Codec(Alphabets.IPv6, AlgoType.IPv6);
    test('IPv6 encode', () {
      var address = InternetAddress('1080::8:800:200c:417a');
      expect(
        '4)+k&C#VzJ4br>0wv%Yp',
        codec.encode(address.rawAddress),
      );
    });

    test('IPv6 decode', () {
      var address = InternetAddress.fromRawAddress(
          codec.decode('4)+k&C#VzJ4br>0wv%Yp'),
          type: InternetAddressType.IPv6);
      expect(
        '1080::8:800:200c:417a',
        address.address,
      );
    });
  });
}
