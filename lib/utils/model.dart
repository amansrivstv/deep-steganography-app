import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class DeepSteganography {
  final _revealModelFile = 'reveal.tflite';
  final _hideModelFile = 'hide.tflite';

  static const int MODEL_IMAGE_SIZE = 224;

  Interpreter interpreterReveal;
  Interpreter interpreterHide;

  Future<void> loadModel() async {
    // TODO Exception
    interpreterReveal = await Interpreter.fromAsset(_revealModelFile);
    interpreterHide = await Interpreter.fromAsset(_hideModelFile);
  }

  Future<Uint8List> loadHiddenImage(String hiddenImagePath) async {
    var hiddenImageByteData = await rootBundle.load(hiddenImagePath);
    return hiddenImageByteData.buffer.asUint8List();
  }

  Future<Uint8List> hideImage(
      Uint8List coverImage, Uint8List secretImage) async {
    var coverImageTemp = img.decodeImage(coverImage);
    var coverImageFinal = img.copyResize(coverImageTemp,
        width: MODEL_IMAGE_SIZE, height: MODEL_IMAGE_SIZE);
    var modelhideCoverInput =
        _imageToByteListUInt8(coverImageFinal, MODEL_IMAGE_SIZE, 0, 255);
    var secretImageTemp = img.decodeImage(secretImage);
    var secretImageFinal = img.copyResize(secretImageTemp,
        width: MODEL_IMAGE_SIZE, height: MODEL_IMAGE_SIZE);
    var modelhideSecretInput =
        _imageToByteListUInt8(secretImageFinal, MODEL_IMAGE_SIZE, 0, 255);
    var inputsFormodelhide = [modelhideCoverInput, modelhideSecretInput];

    var outputsFormodelhide = Map<int, dynamic>();
    // image 1 224 224 3
    var outputImageData = [
      List.generate(
        MODEL_IMAGE_SIZE,
        (index) => List.generate(
          MODEL_IMAGE_SIZE,
          (index) => List.generate(3, (index) => 0.0),
        ),
      ),
    ];
    outputsFormodelhide[0] = outputImageData;

    interpreterHide.runForMultipleInputs(
        inputsFormodelhide, outputsFormodelhide);

    var outputImage = _convertArrayToImage(outputImageData, MODEL_IMAGE_SIZE);
    var rotateOutputImage = img.copyRotate(outputImage, 90);
    var flipOutputImage = img.flipHorizontal(rotateOutputImage);
    var resultImage = img.copyResize(flipOutputImage,
        width: coverImageTemp.width, height: coverImageTemp.height);

    return img.encodeJpg(resultImage);
  }

  Future<Uint8List> revealImage(Uint8List hiddenImage) async {
    var hiddenImageTemp = img.decodeImage(hiddenImage);
    var hiddenImageFinal = img.copyResize(hiddenImageTemp,
        width: MODEL_IMAGE_SIZE, height: MODEL_IMAGE_SIZE);
    var modelRevealInput =
        _imageToByteListUInt8(hiddenImageFinal, MODEL_IMAGE_SIZE, 0, 255);
    var inputsFormodelreveal = [modelRevealInput];

    var outputsFormodelreveal = Map<int, dynamic>();
    // image 1 224 224 3
    var outputImageData = [
      List.generate(
        MODEL_IMAGE_SIZE,
        (index) => List.generate(
          MODEL_IMAGE_SIZE,
          (index) => List.generate(3, (index) => 0.0),
        ),
      ),
    ];
    outputsFormodelreveal[0] = outputImageData;

    interpreterReveal.runForMultipleInputs(
        inputsFormodelreveal, outputsFormodelreveal);

    var outputImage = _convertArrayToImage(outputImageData, MODEL_IMAGE_SIZE);
    var rotateOutputImage = img.copyRotate(outputImage, 90);
    var flipOutputImage = img.flipHorizontal(rotateOutputImage);
    var resultImage = img.copyResize(flipOutputImage,
        width: hiddenImageTemp.width, height: hiddenImageTemp.height);
    return img.encodeJpg(resultImage);
  }

  img.Image _convertArrayToImage(
      List<List<List<List<double>>>> imageArray, int inputSize) {
    img.Image image = img.Image.rgb(inputSize, inputSize);
    for (var x = 0; x < imageArray[0].length; x++) {
      for (var y = 0; y < imageArray[0][0].length; y++) {
        var r = (imageArray[0][x][y][0] * 255).toInt();
        var g = (imageArray[0][x][y][1] * 255).toInt();
        var b = (imageArray[0][x][y][2] * 255).toInt();
        image.setPixelRgba(x, y, r, g, b);
      }
    }
    return image;
  }

  Uint8List _imageToByteListUInt8(
    img.Image image,
    int inputSize,
    double mean,
    double std,
  ) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;

    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }
}
