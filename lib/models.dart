class Feeds {
  String title;
  String url;

  Feeds({this.title, this.url});

  Feeds.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['url'] = this.url;
    return data;
  }

  @override
  String toString() {
    return "Feed{ $title, $url}";
  }
}
