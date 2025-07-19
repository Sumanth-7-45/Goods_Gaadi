class UserModel{
  String? uid;
  String? Name;
  String? Email;
  String? Phoneno;

  UserModel(
  {
    this.Email,this.Name,this.Phoneno,this.uid
}
      );
  //data from server
  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['Uid'],
      Name: map['Name'],
      Email: map['E-mail'],
      Phoneno: map['Phone-NO']
    );
  }
  // data to server
Map<String,dynamic> toMap(){
    return {
      'Uid':uid,'Name':Name,'Email':Email,'Phone':Phoneno
    };
}
}