part of base85;

var _byteMask = BigInt.from(0xff);

class Ipv6Decoder extends Converter<String, Uint8List> {
  String alphabet;
  Uint8List _baseMap;

  Ipv6Decoder(this.alphabet) {
    _baseMap = Uint8List(256);
    _baseMap.fillRange(0, _baseMap.length, 255);
    for (var i = 0; i < alphabet.length; i++) {
      var xc = alphabet.codeUnitAt(i);
      if (_baseMap[xc] != 255) {
        throw FormatException('${alphabet[i]} is ambiguous');
      }
      _baseMap[xc] = i;
    }
  }

  @override

  /// [input] length of data must be exactly 20 bytes.
  Uint8List convert(String input) {
    if (20 != input.length) {
      throw FormatException('An encoded IPv6 is always (5/4) * 16 = 20 bytes');
    }

    var count = 0;

    var map = input.split('');
    var binary = BigInt.zero;
    for (var i = map.length - 1; i >= 0; i--) {
      var num = BigInt.from(_baseMap[map[i].codeUnits[0]]);
      var fact = BigInt.from(85).pow(count++);
      var contrib = num * fact;
      binary += contrib;
    }

    var size = (binary.bitLength + 7) >> 3;
    var bytes = Uint8List(size);
    for (var i = 0; i < size; i++) {
      bytes[size - i - 1] = (binary & _byteMask).toInt();
      binary >>= 8;
    }
    return bytes;
  }
}
