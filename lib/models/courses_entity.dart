import 'dart:ffi';

import 'home_entity.dart';

class CoursesEntity {
	List<CoursesModel> courses;
	int status;

	CoursesEntity({this.courses, this.status});

	CoursesEntity.fromJson(Map<String, dynamic> json) {
		if (json['courses'] != null) {
			courses = new List<CoursesModel>();
			json['courses'].forEach((v) {
				courses.add(new CoursesModel.fromJson(v));
			});
		}
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.courses != null) {
			data['courses'] = this.courses.map((v) => v.toJson()).toList();
		}
		data['status'] = this.status;
		return data;
	}
}

class CoursesModel  with HomeListItem{
	int id;
	String picUrl;
	String name;
	int partnum;
	String brief;
	String store;
	String addr;
	String counterPrice;

	CoursesModel(
			{
				this.id,
				this.picUrl,
				this.name,
				this.partnum,
				this.brief,
				this.store,
				this.addr,
				this.counterPrice});

	CoursesModel.fromJson(Map<String, dynamic> json) {
		picUrl = json['picUrl'] != null ? json['picUrl'].toString() : "";
		name = json['name'] != null ? json['name'].toString() : "";
		store = json['store'] != null ? json['store'].toString() : "";
		addr = json['addr'] != null ? json['addr'].toString() : "";
		id = json['id'] ?? 0;
		partnum = json['partnum'] ?? 0;
		brief = json['brief'] != null  ? json['brief'].toString() : "";
		counterPrice = json['counterPrice'] != null ?json['counterPrice'].toString() : "0";
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['picUrl'] = this.picUrl;
		data['name'] = this.name;
		data['id'] = this.id;
		data['store'] = this.store;
		data['addr'] = this.addr;
		data['partnum'] = this.partnum;
		data['brief'] = this.brief;
		data['counterPrice'] = this.counterPrice;
		return data;
	}
}
