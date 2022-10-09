import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:logger/logger.dart';

mixin FirebaseServiceManager {
  Future<List<BaseFirebaseModel<T>>?> getResponseList<T>(
      Future<
              FirestoreQuerySnapshot<FirestoreDocumentSnapshot,
                  FirestoreDocumentSnapshot>>
          reference) async {
    try {
      final response = await reference;

      return response.docs.map((e) {
        return BaseFirebaseModel<T>(
            id: e.id, data: e.data is T ? (e.data as T) : null);
      }).toList();
    } catch (e) {
      Logger().wtf('$e');
      return null;
    }
  }
}

class BaseFirebaseModel<T> {
  final String id;
  final T? data;
  BaseFirebaseModel({
    required this.id,
    required this.data,
  });
}
