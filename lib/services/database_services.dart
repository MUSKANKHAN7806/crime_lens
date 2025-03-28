import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crime_lens/models/complain_model.dart';
import 'package:crime_lens/screens/criminal_details_page.dart';
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

  Stream<QuerySnapshot<Map<String, dynamic>>> getComplains() {
    List<ComplainModel> complains = [];
    String currentUserId = AuthService.getUid();
    final responseList = firestore
        .collection('complains')
        .where('uid', isEqualTo: currentUserId)
        .snapshots();
    // for (var doc in responseList.) {
    //   final singleComplain = ComplainModel.fromJson(doc.data());
    //   complains.add(singleComplain);
    // }
    return responseList;
  }

  Future<SuspectDetails> getCriminalData(String criminalUid) async {
    final response =
        await firestore.collection('criminal').doc(criminalUid).get();
    final responseData = response.data();
    final details = SuspectDetails.fromJson(responseData!);
    return details;
  }
}
