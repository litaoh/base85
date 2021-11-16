part of base85;

enum AlgoType { ascii85, z85, IPv6 }

class Base85Codec extends Codec<Uint8List, String> {
  final String alphabet;
  Converter<Uint8List, String>? _encoder;
  Converter<String, Uint8List>? _decoder;
  AlgoType algo;

  Base85Codec(this.alphabet, [this.algo = AlgoType.z85]);

  @override
  Converter<Uint8List, String> get encoder {
    if (algo == AlgoType.IPv6) {
      _encoder ??= Ipv6Encoder(alphabet);
    } else {
      _encoder ??= Base85Encoder(alphabet, algo);
    }
    return _encoder!;
  }

  @override
  Converter<String, Uint8List> get decoder {
    if (algo == AlgoType.IPv6) {
      _decoder ??= Ipv6Decoder(alphabet);
    } else {
      _decoder ??= Base85Decoder(alphabet, algo);
    }
    return _decoder!;
  }
}
