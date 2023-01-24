class PostModel {
  String? name;
  String? uId;
  String? date;
  String? image;
  String? post;
  String? postImage;


  PostModel({this.uId, this.post, this.name, this.postImage,this.date,this.image});


  PostModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    date = json['date'];
    name = json['name'];
    image = json['image'];
    post = json['post'];
    postImage = json['postImage'];

  }

  Map <String,dynamic> toMap(){

    return {
      'name':name,
      'post':post, // الإيميل هيتسجل في الموقع تحت المسمي ده
      'date':date,
      'image':image,
      'postImage':postImage,
      'uId':uId,

    };
  }

}
