class ImageModel {

  int? id;
  String? title;
  String? url;


  ImageModel({ this.id, this.title, this.url,});

  ImageModel.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;

    return data;
  }
}