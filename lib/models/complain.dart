class ComplainModel{
  final String name;
  final String description;
  final DateTime date;
  final String attachmentUrl;

  ComplainModel({required this.name, required this.description, required this.date, required this.attachmentUrl});

  factory ComplainModel.fromJson(Map<String,dynamic> json){
    return ComplainModel(name: json['name'], description: json['description'], date: json['date'], attachmentUrl: json['attachmentUrl']);
  }

  Map<String,dynamic> toJson(ComplainModel model)=>{
    'name': model.name,
    'description': model.description,
    'date': model.date,
    'attachmentUrl': model.attachmentUrl
  };
}