import 'dart:typed_data';
import 'package:multi_image_picker/multi_image_picker.dart';

class ImageService {

  Future<Uint8List> loadImage() async {
    var resultList = await MultiImagePicker.pickImages(
      maxImages: 1,
      enableCamera: true,
    );

    if (resultList.length == 0) {
      return null;
    } else {
      return readAsBytes(resultList);
    }
  }

  Future<Uint8List> readAsBytes(List<Asset> assets) async {
    var asset = assets.single;
    var byteData = await asset.getByteData();
    return byteData.buffer.asUint8List();
  }
}
