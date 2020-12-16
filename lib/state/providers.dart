import 'package:deep_steganography_app/models/image_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final imageProvider = ChangeNotifierProvider((ref) => ImageStorage());
