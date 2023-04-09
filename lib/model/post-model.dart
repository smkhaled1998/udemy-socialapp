class PostModel {

  String? uId;
  String? date;
  String? post;
  String? postImage;


  PostModel({this.uId, this.post, this.postImage,this.date});


  PostModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    date = json['date'];
    post = json['post'];
    postImage = json['postImage'];

  }

  Map <String,dynamic> toMap(){

    return {
      'post':post, // الإيميل هيتسجل في الموقع تحت المسمي ده
      'date':date,
      'postImage':postImage,
      'uId':uId,

    };
  }

}
