import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crime_lens/models/complain_model.dart';
import 'package:crime_lens/services/auth_services.dart';

class FirebaseDatabaseServices {
  static final firestore = FirebaseFirestore.instance;

  Future addNewUser(UserDetails userDetails, String userId) async {
    await firestore.collection('user').doc(userId).set(userDetails.toJson());
  }

  Future<UserDetails> getCurrentUserDetails() async {
    String userid = AuthService.getUid();
    final response = await firestore.collection('user').doc(userid).get();
    return UserDetails.fromJson(response.data()!);
  }

  Future addNewComplain(ComplainModel complainDetails) async {
    await firestore.collection('complains').add(complainDetails.toJson());
  }
}
