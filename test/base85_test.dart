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
      expect(
        'o<}]Z',
        codec.encode(Uint8List.fromList('Man '.codeUnits)),
      );
      expect(
        'o<}]ZvpA.S',
        codec.encode(Uint8List.fromList('Man abcd'.codeUnits)),
      );
      expect(
        '',
        codec.encode(Uint8List.fromList(''.codeUnits)),
      );
      expect(
        'o<}]Zx(+zcx(!xgzFa9aB7/b}efF?GBrCHty<vdjC{3^mB0bHmvrlv8efFzABrC4raA' //
        'RphB0bKrzFa9dvr9GfvrlH7z/cXfA=k!qz//V7AV!!dx(do{B1wCTxLy%&azC)tvixx'
        'eB95Kyw/#hewGU&7zE+pvBzb98ayYQsvixJ2A=U/nwPzi%v}u^3w/\$R}y?WJ}BrCpna'
        'ARpday/tcBzkSnwN(](zE:(7zE^r<vrui@vpB4:azkn6wPzj3x(v(iz!pbczF%-nwN]'
        'B+efFIGv}xjZB0bNrwGV5cz/P}xC4Ct#zdNP{wGU]6ayPekay!&2zEEu7Abo8]B9hIm',
        codec.encode(
          Uint8List.fromList(
            ('Man is distinguished, not only by his reason, but by this singular passion ' //
                    'from other animals, which is a lust of the mind, that by a perseverance of '
                    'delight in the continued and indefatigable generation of knowledge, exceeds '
                    'the short vehemence of any carnal pleasure')
                .codeUnits,
          ),
        ),
      );
      expect(
        '00000',
        codec.encode(Uint8List.fromList([0x0, 0x0, 0x0, 0x0])),
      );
      expect(
        'HelloWorld',
        codec.encode(Uint8List.fromList(
          [0x86, 0x4F, 0xD2, 0x6F, 0xB5, 0x59, 0xF7, 0x5B],
        )),
      );
      expect(
        'JTKVSB%%)wK0E.X)V>+}o?pNmC{O&4W4b!Ni{Lh6',
        codec.encode(Uint8List.fromList([
          0x8E, 0x0B, 0xDD, 0x69, 0x76, 0x28, 0xB9, 0x1D, 0x8F, 0x24, 0x55, //
          0x87, 0xEE, 0x95, 0xC5, 0xB0, 0x4D, 0x48, 0x96, 0x3F, 0x79, 0x25,
          0x98, 0x77, 0xB4, 0x9C, 0xD9, 0x06, 0x3A, 0xEA, 0xD3, 0xB7
        ])),
      );
    });

    test('z85 decode', () {
      expect(
        'Hello, world!!!!',
        String.fromCharCodes(codec.decode('nm=QNz.92Pz/PV8aT50L')),
      );
      expect(
        'Man ',
        String.fromCharCodes(codec.decode('o<}]Z')),
      );
      expect(
        'Man abcd',
        String.fromCharCodes(codec.decode('o<}]ZvpA.S')),
      );
      expect(
        '',
        String.fromCharCodes(codec.decode('')),
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
      expect(
        '<~9jqo^~>',
        codec.encode(Uint8List.fromList('Man '.codeUnits)),
      );
      expect(
        '<~9jqo^@/~>',
        codec.encode(Uint8List.fromList('Man a'.codeUnits)),
      );
      expect(
        '<~9jqo^@:B~>',
        codec.encode(Uint8List.fromList('Man ab'.codeUnits)),
      );
      expect(
        '<~9jqo^@:E^~>',
        codec.encode(Uint8List.fromList('Man abc'.codeUnits)),
      );
      expect(
        '<~9jqo^@:E_W~>',
        codec.encode(Uint8List.fromList('Man abcd'.codeUnits)),
      );
      expect(
        '<~~>',
        codec.encode(Uint8List.fromList(''.codeUnits)),
      );
      expect(
        '<~9jqo^BlbD-BleB1DJ+*+F(f,q/0JhKF<GL>Cj@.4Gp\$d7F!,L7@<6@)/0JDEF' //
        '<G%<+EV:2F!,O<DJ+*.@<*K0@<6L(Df-\\0Ec5e;DffZ(EZee.Bl.9pF"AGXBPC'
        'si+DGm>@3BB/F*&OCAfu2/AKYi(DIb:@FD,*)+C]U=@3BN#EcYf8ATD3s@q?d\$A'
        'ftVqCh[NqF<G:8+EV:.+Cf>-FD5W8ARlolDIal(DId<j@<?3r@:F%a+D58\'ATD'
        '4\$Bl@l3De:,-DJs`8ARoFb/0JMK@qB4^F!,R<AKZ&-DfTqBG%G>uD.RTpAKYo\''
        '+CT/5+Cei#DII?(E,9)oF*2M7~>',
        codec.encode(
          Uint8List.fromList(
            ('Man is distinguished, not only by his reason, but by this singular passion ' //
                    'from other animals, which is a lust of the mind, that by a perseverance of '
                    'delight in the continued and indefatigable generation of knowledge, exceeds '
                    'the short vehemence of any carnal pleasure')
                .codeUnits,
          ),
        ),
      );
    });

    test('ascii85 decode', () {
      expect(
        'Hello, world',
        String.fromCharCodes(codec.decode('<~87cURD_*#TDfTZ)~>')),
      );
      expect(
        'Man ',
        String.fromCharCodes(codec.decode('<~9jqo^~>')),
      );
      expect(
        'Man a',
        String.fromCharCodes(codec.decode('<~9jqo^@/~>')),
      );
      expect(
        'Man ab',
        String.fromCharCodes(codec.decode('<~9jqo^@:B~>')),
      );
      expect(
        'Man abc',
        String.fromCharCodes(codec.decode('<~9jqo^@:E^~>')),
      );
      expect(
        'Man abcd',
        String.fromCharCodes(codec.decode('<~9jqo^@:E_W~>')),
      );
      expect(
        '',
        String.fromCharCodes(codec.decode('<~~>')),
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
        type: InternetAddressType.IPv6,
      );
      expect(
        '1080::8:800:200c:417a',
        address.address,
      );
    });
  });
}
