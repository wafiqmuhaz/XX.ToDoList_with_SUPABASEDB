// ignore_for_file: prefer_is_empty

class Notes {
  int? id;
  int? userId;
  String? title;
  String? desc;
  String? createdAt;

  Notes({this.id, this.userId, this.title, this.desc, this.createdAt});

  Notes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    desc = json['desc'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['title'] = title;
    data['desc'] = desc;
    data['created_at'] = createdAt;
    return data;
  }

  static List<Notes> fromJsonList(List? data) {
    if (data == null || data.length == 0) return [];
    return data
        .map(
          (e) => Notes.fromJson(e),
        )
        .toList();
  }
}
