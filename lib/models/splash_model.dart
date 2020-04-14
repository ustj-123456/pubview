class SplashModel {
  String title;
  String content;
  String url;
  String imgUrl;
  String extraUrl;

  SplashModel({this.title, this.content, this.url, this.imgUrl, this.extraUrl});

  SplashModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        content = json['content'],
        url = json['url'],
        imgUrl = json['imgUrl'],
        extraUrl = json['extraUrl'];

  Map<String, dynamic> toJson() => {
    'title': title,
    'content': content,
    'url': url,
    'imgUrl': imgUrl,
    'extraUrl': extraUrl,
  };

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write("\"title\":\"$title\"");
    sb.write(",\"content\":\"$content\"");
    sb.write(",\"url\":\"$url\"");
    sb.write(",\"imgUrl\":\"$imgUrl\"");
    sb.write(",\"extraUrl\":\"$extraUrl\"");
    sb.write('}');
    return sb.toString();
  }
}
