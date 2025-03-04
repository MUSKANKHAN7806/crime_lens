class ComplainModel {
  final String uid;
  final UserDetails userDetails;
  final IncidentDetails incidentDetails;
  final String? attachmentUrl;
  // final List<SuspectDetails>? suspectDetails;
  // final List<VehicleDetails>? vehicleDetails;
  // final List<WitnessDetails>? witnessDetails;

  ComplainModel(
      {required this.uid,
      required this.userDetails,
      required this.incidentDetails,
      this.attachmentUrl
      // required this.suspectDetails,
      // required this.vehicleDetails,
      // required this.witnessDetails
      });

  factory ComplainModel.fromJson(Map<String, dynamic> json) {
    return ComplainModel(
        uid: json['uid'],
        userDetails: UserDetails.fromJson(json['user_details']),
        incidentDetails: IncidentDetails.fromJson(json['incident_details']),
        attachmentUrl: json['attachment_url']
        // suspectDetails: (json['suspect_details'] as List?)
        //     ?.map((e) => SuspectDetails.fromJson(e))
        //     .toList(),
        // vehicleDetails: (json['vehicle_details'] as List?)
        //     ?.map((e) => VehicleDetails.fromJson(e))
        //     .toList(),
        // witnessDetails: (json['witness_details'] as List?)
        //     ?.map((e) => WitnessDetails.fromJson(e))
        //     .toList(),
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'user_details': userDetails.toJson(),
      'incident_details': incidentDetails.toJson(),
      'attachment_url': attachmentUrl
      // 'suspect_details': suspectDetails?.map((e) => e.toJson()).toList(),
      // 'vehicle_details': vehicleDetails?.map((e) => e.toJson()).toList(),
      // 'witness_details': witnessDetails?.map((e) => e.toJson()).toList(),
    };
  }
}

class UserDetails {
  final String name;
  final String aadhar;
  final String address;
  final String mobileNumber;
  final String email;

  UserDetails(
      {required this.name,
      required this.aadhar,
      required this.address,
      required this.mobileNumber,
      required this.email});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      name: json['name'],
      aadhar: json['aadhar_number'],
      address: json['address'],
      mobileNumber: json['phone_number'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'aadhar_number': aadhar,
      'address': address,
      'phone_number': mobileNumber,
      'email': email,
    };
  }
}

class IncidentDetails {
  final DateTime dateTime;
  final String location; //////
  final String type;
  final String description;

  IncidentDetails(
      {required this.dateTime,
      required this.location,
      required this.type,
      required this.description});

  factory IncidentDetails.fromJson(Map<String, dynamic> json) {
    return IncidentDetails(
      dateTime: DateTime.parse(json['date_time']),
      location: json['location'],
      type: json['type'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date_time': dateTime.toIso8601String(),
      'location': location,
      'type': type,
      'description': description,
    };
  }
}

class SuspectDetails {
  final String name;
  final String? physicalDescription;
  final String otherFeatures;
  SuspectDetails(
      {required this.name,
      required this.otherFeatures,
      this.physicalDescription});

  factory SuspectDetails.fromJson(Map<String, dynamic> json) {
    return SuspectDetails(
      name: json['name'],
      otherFeatures: json['other_features'],
      physicalDescription: json['physical_description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'physical_description': physicalDescription,
      'other_features': otherFeatures,
    };
  }
}

class VehicleDetails {
  final String? color;
  final String? name;
  final String? number;
  final String? description;

  VehicleDetails({this.color, this.name, this.number, this.description});

  factory VehicleDetails.fromJson(Map<String, dynamic> json) {
    return VehicleDetails(
      color: json['color'],
      name: json['name'],
      number: json['number'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'color': color,
      'name': name,
      'number': number,
      'description': description,
    };
  }
}

class WitnessDetails {
  final String? name;
  final String? relation;
  final String? contactNumber;
  final String? otherInfo;

  WitnessDetails(
      {this.name, this.relation, this.contactNumber, this.otherInfo});

  factory WitnessDetails.fromJson(Map<String, dynamic> json) {
    return WitnessDetails(
      name: json['name'],
      relation: json['relation'],
      contactNumber: json['contact_number'],
      otherInfo: json['other_info'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'relation': relation,
      'contact_number': contactNumber,
      'other_info': otherInfo,
    };
  }
}
