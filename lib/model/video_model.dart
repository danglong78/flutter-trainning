class VideoModel {
  String description;
  String videoUrl;
  String imgUrl;
  String title;
  VideoModel(this.title, this.description, this.videoUrl, this.imgUrl);

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
        json['title'], json['description'], json['sources'], json['thumb']);
  }
}
