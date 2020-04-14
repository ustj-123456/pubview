class UserModel {
	int id;
	String username;
	int userLevel;
	String nickname;
	String mobile;
	String weixinOpenid;
	String sessionKey;
	String avatar;
	int studyTime;
	String token;

	UserModel(
			{
				this.id,
				this.username,
				this.userLevel,
				this.nickname,
				this.mobile,
				this.weixinOpenid,
				this.sessionKey,
				this.avatar,
				this.studyTime,
				this.token
			});
	UserModel.fromJson(Map<String, dynamic> json) {
		id = json['id'] ?? 0;
		username = json['username'] ?? "";
		userLevel = json['userLevel'] ?? 0;
		nickname = json['nickname'] ?? "";
		mobile = json['mobile'] ?? "";
		weixinOpenid = json['weixinOpenid'] ?? "";
		sessionKey = json['sessionKey'] ?? "";
		avatar = json['avatar'] ?? "";
		studyTime = json['studyTime'] ?? 0;
		token = json['token'] ?? "";
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['username'] = this.username;
		data['userLevel'] = this.userLevel;
		data['nickname'] = this.nickname;
		data['mobile'] = this.mobile;
		data['weixinOpenid'] = this.weixinOpenid;
		data['sessionKey'] = this.sessionKey;
		data['avatar'] = this.avatar;
		data['studyTime'] = this.studyTime;
		data['token'] = this.token;
		return data;
	}
}
