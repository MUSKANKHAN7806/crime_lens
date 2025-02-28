import 'package:crime_lens/services/auth_services.dart';
import 'package:crime_lens/services/database_services.dart';
import 'package:crime_lens/services/theme.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  final String email;
  final String password;
  const UserDetails({super.key, required this.email, required this.password});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    
    late String name;
    late String aadharNumber;
    late String phoneNumber;
    late String address;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/auth_background.jpg'),fit: BoxFit.fill)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(width * 0.05, 30, width * 0.05, 0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: height * 0.28),
                          Text(
                            'Enter details',
                            style: TextStyle(
                                fontSize: 30,
                                color: kMeeshoPurple,
                                fontFamily: "DancingScript",
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: height * 0.01),
                          TextFormField(
                            validator: (val) => val!.isEmpty
                                ? 'This is a required field'
                                : null,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black, fontSize: 19),
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2)),
                                hintStyle: TextStyle(
                                    fontSize: 19, color: Colors.black87),
                                hintText: 'Name'),
                            onChanged: (val) {
                              name = val;
                            },
                          ),
                          SizedBox(height: height * 0.02),
                          TextFormField(
                            validator: (val) => val!.isEmpty
                                ? 'This is a required field'
                                : null,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black, fontSize: 19),
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2)),
                                hintStyle: TextStyle(
                                    fontSize: 19, color: Colors.black87),
                                hintText: 'Aadhar Number'),
                            onChanged: (val) {
                              aadharNumber = val;
                            },
                          ),
                          SizedBox(height: height * 0.02),
                          TextFormField(
                            validator: (val) => val!.isEmpty
                                ? 'This is a required field'
                                : null,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black, fontSize: 19),
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2)),
                                hintStyle: TextStyle(
                                    fontSize: 19, color: Colors.black87),
                                hintText: 'Phone Number'),
                            onChanged: (val) {
                              phoneNumber = val;
                            },
                          ),
                          SizedBox(height: height * 0.02),
                          TextFormField(
                            validator: (val) => val!.isEmpty
                                ? 'This is a required field'
                                : null,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black, fontSize: 19),
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2)),
                                hintStyle: TextStyle(
                                    fontSize: 19, color: Colors.black87),
                                hintText: 'Address'),
                            onChanged: (val) {
                              address = val;
                            },
                          ),
                          const SizedBox(height: 20,),
                          FilledButton(onPressed: ()async{
                            if(_formKey.currentState!.validate()){
                              final uid = await AuthService().registerWithEmailAndPassword(widget.email, widget.password);
                              await FirebaseDatabaseServices().addNewUser(uid!, name, aadharNumber, phoneNumber, address);
                              Navigator.of(context).pop();
                            }
                          }, child: Text('Submit'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}