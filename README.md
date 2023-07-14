# base85

Base85 encoder/decoder written in native Dart.

Where base64 adds approximately 1/3, base85 only adds about 1/4. Of course there's a tradeoff. The Base85 alphabet
includes characters that might not be as friendly as the base64 alphabet. While it's still only printable characters,
the Ascii85 specification contains quotes (' and ") which needs escaping in many programming languages, and the ZeroMQ
specification contains < and > which need escaping in most (all?) SGML languages.

IPv6 encoding should only be used for encoding IPv6 addresses. When using IPv6, input for encoding must always be 16
bytes, and input for decoding must always be 20 bytes.

ZeroMQ's version (z85) require according to the specification) string input to be divisible by 5, and binary input to be
divisible by 4.

Supported encoding specifications

* [Ascii85](http://en.wikipedia.org/wiki/Ascii85)
* [ZeroMQ](http://rfc.zeromq.org/spec:32)
* [IPv6](https://tools.ietf.org/html/rfc1924)

## Example

Base85

``` dart
import 'dart:io';
import 'dart:typed_data';

import 'package:base85/base85.dart';

void main() {
  var codec = Base85Codec(Alphabets.z85);
  var encode = codec.encode(Uint8List.fromList('Hello, world!!!!'.codeUnits));
  print(encode);

  /// =>   nm=QNz.92Pz/PV8aT50L
  print(String.fromCharCodes(codec.decode(encode)));

  /// =>   Hello, world!!!!

  codec = Base85Codec(Alphabets.ascii85, AlgoType.ascii85);
  print(codec.encode(Uint8List.fromList('Hello, world'.codeUnits)));

  /// =>    <~87cURD_*#TDfTZ)~>
  print(String.fromCharCodes(codec.decode('<~87cURD_*#TDfTZ)~>')));

  /// =>    Hello, world

  codec = Base85Codec(Alphabets.IPv6, AlgoType.IPv6);
  var address = InternetAddress(
    '1080::8:800:200c:417a',
    type: InternetAddressType.IPv6,
  );
  print(codec.encode(address.rawAddress));

  /// =>    4)+k&C#VzJ4br>0wv%Yp
  ///
  var decode = codec.decode('4)+k&C#VzJ4br>0wv%Yp');
  address = InternetAddress.fromRawAddress(
    decode,
    type: InternetAddressType.IPv6,
  );
  print(address.address);

  /// =>    1080::8:800:200c:417a
}

```