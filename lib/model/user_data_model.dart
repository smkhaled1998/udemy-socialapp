class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  bool? isEmailVerified;
  String? image;
  String? bio;
  String? cover;

  UserModel({this.uId, this.email,  this.name,  this.phone,this.isEmailVerified,this.image,this.bio,this.cover});


  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    uId = json['uId'];
    phone = json['phone'];
    name = json['name'];
    image = json['image'];
    bio = json['bio'];
    cover = json['cover'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map <String,dynamic> toMap(){
    
    return {
      'name':name,
      'email':email, // الإيميل هيتسجل في الموقع تحت المسمي ده
      'phone':phone,//وهكذا
      'isEmailVerified':isEmailVerified,
      'image':image,
      'bio':bio,
      'uId':uId,
      'cover':cover,
    };
  }

}
