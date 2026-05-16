import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/universidad.dart';

class UniversidadService {
  final CollectionReference _universidades =
      FirebaseFirestore.instance.collection('universidades');

  Stream<List<Universidad>> getUniversidades() {
    return _universidades.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Universidad.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList());
  }

  Future<void> agregarUniversidad(Universidad universidad) async {
    await _universidades.add(universidad.toMap());
  }
}