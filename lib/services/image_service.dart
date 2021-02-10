import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class ImageService {
  final picker = ImagePicker();

  Future<Uint8List> cameraImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    return readAsBytes(pickedFile);
  }

  Future<Uint8List> loadImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    return readAsBytes(pickedFile);
  }

  Future<Uint8List> readAsBytes(PickedFile pickedFile) {
    if (pickedFile != null) {
      return pickedFile.readAsBytes();
    } else {
      return null;
    }
  }
}