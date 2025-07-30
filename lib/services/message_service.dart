import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/models.dart';

class MessageService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<MessageModel>> getMessagesByUserId({required int userId}) {
    try {
      return firestore
          .collection('messages')
          .where('userId', isEqualTo: userId)
          .snapshots()
          .map((QuerySnapshot list) {
            var result = list.docs.map<MessageModel>((
              DocumentSnapshot message,
            ) {
              Map<String, dynamic> datos =
                  message.data() as Map<String, dynamic>;
              return MessageModel.fromJson(datos);
            }).toList();
            result.sort(
              (MessageModel a, MessageModel b) =>
                  a.createdAt!.compareTo(b.createdAt!),
            );

            return result;
          });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> addMessage({
    required UserModel user,
    required bool isFromUser,
    required String message,
    required ProductModel product,
  }) async {
    try {
      firestore
          .collection('messages')
          .add({
            'userId': user.id,
            'userName': user.name,
            'userImage': user.profilePhotoUrl,
            'isFromUser': isFromUser,
            'message': message,
            'product': product is UninitializedProductModel
                ? null
                : product.toJson(),
            'createdAt': DateTime.now().toString(),
            'updatedAt': DateTime.now().toString(),
          })
          .then((value) => print('Pesan Berhasil Dikirim!'));
    } catch (e) {
      throw Exception('Pesan Gagal Dikirim!');
    }
  }
}
