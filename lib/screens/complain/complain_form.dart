import 'dart:io';

import 'package:crime_lens/models/complain_model.dart';
import 'package:crime_lens/services/auth_services.dart';
import 'package:crime_lens/services/database_services.dart';
import 'package:crime_lens/widgets/empty_widget.dart';
import 'package:crime_lens/widgets/form_text_field.dart';
import 'package:crime_lens/widgets/loading.dart';
import 'package:flutter/material.dart';

class ComplainForm extends StatefulWidget {
  final File? attachment;
  const ComplainForm({super.key, this.attachment});

  @override
  State<ComplainForm> createState() => _ComplainFormState();
}

class _ComplainFormState extends State<ComplainForm> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();
  final peopleInvolvedCOntroller = TextEditingController();
  List<Map<String, dynamic>> witnessDetails = [];
  List<Map<String, dynamic>> suspectDetails = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Enter Complain Details'),
        ),
        body: FutureBuilder(
            future: FirebaseDatabaseServices().getCurrentUserDetails(),
            builder: (context, AsyncSnapshot<UserDetails> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingWidget();
              }
              if (snapshot.connectionState == ConnectionState.done) {
                final data = snapshot.data!;
                return FormBody(
                  attachment: widget.attachment,
                  userDetails: data,
                );
              }
              return FormBody();
            }));
  }
}

class FormBody extends StatefulWidget {
  final File? attachment;
  final ComplainModel? initialData;
  final UserDetails? userDetails;
  const FormBody(
      {super.key, this.initialData, this.userDetails, this.attachment});

  @override
  State<FormBody> createState() => _FormBodyState();
}

class _FormBodyState extends State<FormBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final aadharController = TextEditingController();
  final addressController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final emailController = TextEditingController();
  final locationController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final typeController = TextEditingController();
  final descriptionController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    if (widget.userDetails != null) {
      nameController.text = widget.userDetails!.name;
      aadharController.text = widget.userDetails!.aadhar;
      addressController.text = widget.userDetails!.address;
      mobileNumberController.text = widget.userDetails!.mobileNumber;
      emailController.text = widget.userDetails!.email;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    const titleTextStyle =
        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600);

    return isLoading
        ? const LoadingWidget()
        : SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your Details',
                        style: titleTextStyle,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      FormTextField(
                        labelText: 'Name',
                        controller: nameController,
                      ),
                      FormTextField(
                        labelText: 'Aadhar Number',
                        controller: aadharController,
                      ),
                      FormTextField(
                        labelText: 'Address',
                        controller: addressController,
                      ),
                      FormTextField(
                        labelText: 'Mobile Number',
                        controller: mobileNumberController,
                      ),
                      FormTextField(
                        labelText: 'Email',
                        controller: emailController,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        'Incident Details',
                        style: titleTextStyle,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      FormTextField(
                        labelText:
                            'Location (Building, Street, Locality, pincode)',
                        controller: locationController,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: SizedBox(
                              child: FormTextField(
                                labelText: 'labelText',
                                controller: dateController,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: SizedBox(
                              child: FormTextField(
                                labelText: 'labelText',
                                controller: timeController,
                              ),
                            ),
                          )
                        ],
                      ),
                      FormTextField(
                        labelText: 'Type',
                        controller: typeController,
                      ),
                      FormTextField(
                        labelText: 'Decription',
                        isTextArea: true,
                        controller: descriptionController,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      widget.attachment != null
                          ? const Text(
                              'Attachments',
                              style: titleTextStyle,
                            )
                          : const EmptyWidget(),
                      widget.attachment != null
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.file_copy),
                                  const SizedBox(
                                    width: 12.0,
                                  ),
                                  Text(
                                      (widget.attachment!.path).split('/').last)
                                ],
                              ),
                            )
                          : const EmptyWidget(),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Center(
                        child: FilledButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final userDetails = UserDetails(
                                    name: nameController.text,
                                    aadhar: aadharController.text,
                                    address: addressController.text,
                                    mobileNumber: mobileNumberController.text,
                                    email: emailController.text);
                                final incidentDetails = IncidentDetails(
                                    dateTime: DateTime.now(),
                                    location: locationController.text,
                                    type: typeController.text,
                                    description: descriptionController.text);
                                final complainDetails = ComplainModel(
                                    uid: AuthService.getUid(),
                                    userDetails: userDetails,
                                    incidentDetails: incidentDetails);
                                setState(() {
                                  isLoading = true;
                                });
                                await FirebaseDatabaseServices()
                                    .addNewComplain(complainDetails);
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.of(context).pop();
                                // Fluttertoast.showToast(
                                //     msg: 'Registered complain successfully');
                              }
                            },
                            child: Text("Submit")),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                    ],
                  ),
                )),
          );
  }
}
