import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadToFirebase(File file) async {
  String fileName = DateTime.now().millisecondsSinceEpoch.toString();

  Reference ref = FirebaseStorage.instance.ref().child('flowers/$fileName.jpg');

  await ref.putFile(file);

  return await ref.getDownloadURL();
}
