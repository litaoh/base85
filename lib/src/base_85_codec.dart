part of base85;

enum AlgoType { ascii85, z85 }

class Base85Codec extends Codec<Uint8List, String> {
  String alphabet;
  Base85Encoder _encoder;
  Base85Decoder _decoder;
  AlgoType algo;

  Base85Codec(this.alphabet, [this.algo = AlgoType.z85]);

  @override
  Converter<Uint8List, String> get encoder {
    _encoder ??= Base85Encoder(alphabet, this.algo);
    return _encoder;
  }

  @override
  Converter<String, Uint8List> get decoder {
    _decoder ??= Base85Decoder(alphabet, this.algo);
    return _decoder;
  }
}
