import 'package:crypto/crypto.dart' as crypto;
import 'package:encrypt/encrypt.dart' as enc;
import 'dart:typed_data';
import 'dart:convert';

import 'package:soultrain/constants/constants.dart';

class Utility {
  static String encrypt(String string) {
    final enc.Key key = enc.Key.fromUtf8(Constants.aesKey);
    final enc.IV iv = enc.IV.fromUtf8(Constants.IV);

    final dataPadded = pad(Uint8List.fromList(utf8.encode(string)), 16);
    final enc.Encrypter encrypter =
        enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc, padding: null));
    final encryptedJson = encrypter.encryptBytes(dataPadded, iv: iv);

    crypto.Hmac hmacSha256 = crypto.Hmac(crypto.sha256, key.bytes);
    crypto.Digest sha256Result =
        hmacSha256.convert(utf8.encode(iv.base64 + encryptedJson.base64));

    final encryptedText =
        "{\"value\":\"${encryptedJson.base64}\",\"iv\":\"${iv.base64}\",\"mac\":\"$sha256Result\"}";
    return base64.encode(utf8.encode(encryptedText));
  }

  static Uint8List pad(Uint8List plaintext, int blockSize) {
    int padLength =
        (blockSize - (plaintext.lengthInBytes % blockSize)) % blockSize;
    if (padLength != 0) {
      BytesBuilder bb = BytesBuilder();
      Uint8List padding = Uint8List(padLength);
      bb.add(plaintext);
      bb.add(padding);
      return bb.toBytes();
    } else {
      return plaintext;
    }
  }
}
