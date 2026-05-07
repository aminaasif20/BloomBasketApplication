import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> saveToFirestore(String url, String name) async {
  await FirebaseFirestore.instance.collection("flowers").add({
    "name": name,
    "imageUrl": url,
    "price": "1000",
  });
}