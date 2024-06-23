class Users{
  String id;
  String Name;
  String Email;
  int Mobile_number;
  String Address;

  Users({required this.id,required this.Name,required this.Email,required this.Mobile_number,required this.Address});

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'Name':Name,
      'Mobile_number':Mobile_number,
      'Address':Address,
      'Email':Email
    };
  }

  static Users fromJson(Map<String, dynamic> json){
    return Users(
      id: json['id'],

      Name:json['Name'],
      Mobile_number: json['Mobile_number'],
      Address: json['Address'],
      Email:json['Email']

    );
  }

}