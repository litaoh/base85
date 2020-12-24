import 'dart:typed_data';

import 'package:base85/base85.dart';

void main() {
  var z85 = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRST' //
      'UVWXYZ.-:+=^!/*?&<>()[]{}@%\$#';
  var codec = Base85Codec(z85);
  var encode = codec.encode(Uint8List.fromList('Hello, world!!!!'.codeUnits));
  print(encode);

  /// =>   nm=QNz.92Pz/PV8aT50L
  print(String.fromCharCodes(codec.decode(encode)));

  /// =>   Hello, world!!!!

  var ascii85 = '!"#\$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRS' //
      'TUVWXYZ[\\]^_`abcdefghijklmnopqrstu';
  codec = Base85Codec(ascii85);
  print(codec.encode(Uint8List.fromList('Hello, world'.codeUnits)));

  /// =>    87cURD_*#TDfTZ)

  print(String.fromCharCodes(codec.decode('87cURD_*#TDfTZ)')));

  /// =>    Hello, world
}
