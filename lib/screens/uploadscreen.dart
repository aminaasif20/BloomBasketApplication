import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class UploadScreen extends StatelessWidget {
  UploadScreen({super.key});

  final List<String> assetImages = [
    "assets/images/rose.jpg",
    "assets/images/tulip.jpg",
    "assets/images/lily.jpg",
  ];

  Future<File> assetToFile(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);

    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/${assetPath.split('/').last}');

    await file.writeAsBytes(byteData.buffer.asUint8List());

    return file;
  }

  Future<String> uploadToFirebase(File file) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference ref = FirebaseStorage.instance
        .ref()
        .child('flowers/$fileName.jpg');

    await ref.putFile(file);

    return await ref.getDownloadURL();
  }

  Future<void> saveToFirestore(String url, String name) async {
    await FirebaseFirestore.instance.collection("flowers").add({
      "name": name,
      "imageUrl": url,
      "price": "1000",
    });
  }

  Future<void> uploadAllAssets() async {
    for (String path in assetImages) {
      File file = await assetToFile(path);
      String url = await uploadToFirebase(file);
      await saveToFirestore(url, path.split('/').last);
    }

    print("All images uploaded successfully!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Flowers")),
      body: Center(
        child: ElevatedButton(
          onPressed: uploadAllAssets,
          child: const Text("Upload All Flowers to Firebase"),
        ),
      ),
    );
  }
}