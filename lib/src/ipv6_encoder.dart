part of base85;

class Ipv6Encoder extends Converter<Uint8List, String> {
  final String alphabet;

  Ipv6Encoder(this.alphabet);

  @override

  /// [bytes] is expected to be the binary representation of an
  /// IPv6 address (16 bytes)
  String convert(Uint8List bytes) {
    var num = BigInt.zero;
    for (var i = 0; i < bytes.length; i++) {
      num += BigInt.from(bytes[bytes.length - i - 1]) << (8 * i);
    }
    var enc = <String>[];
    for (var i = 1; i < 20; ++i) {
      /* Ranges between 0 - 84 */
      enc.add(alphabet[(num % BigInt.from(85)).toInt()]);
      num = num ~/ BigInt.from(85);
    }
    /* What's left is also in range 0 - 84 */
    enc.add(alphabet[num.toInt()]);
    return enc.reversed.join('');
  }
}
