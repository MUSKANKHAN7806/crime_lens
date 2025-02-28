import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDatabaseServices{

  static final firestore =  FirebaseFirestore.instance;

  Future addNewUser(String userId, String name, String aadharNumber, String phoneNumber, String address)async{
    firestore.collection('user').doc(userId).set({
      'name': name,
      'aadhar_number': aadharNumber,
      'phone_number': phoneNumber,
      'address': address
    });
  }
}