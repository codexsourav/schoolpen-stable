class ParentProfileDataModel {
  String? parentAge;
  String? parentDescription;
  String? parentDesignation;
  String? parentEmail;
  String? parentGender;
  String? parentImage;
  String? parentName;
  String? parentUseridname;

  ParentProfileDataModel(
      {this.parentAge,
      this.parentDescription,
      this.parentDesignation,
      this.parentEmail,
      this.parentGender,
      this.parentImage,
      this.parentName,
      this.parentUseridname});

  ParentProfileDataModel.fromJson(Map<String, dynamic> json) {
    parentAge = json['parent_age'];
    parentDescription = json['parent_description'];
    parentDesignation = json['parent_designation'];
    parentEmail = json['parent_email'];
    parentGender = json['parent_gender'];
    parentImage = json['parent_image'];
    parentName = json['parent_name'];
    parentUseridname = json['parent_useridname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parent_age'] = this.parentAge;
    data['parent_description'] = this.parentDescription;
    data['parent_designation'] = this.parentDesignation;
    data['parent_email'] = this.parentEmail;
    data['parent_gender'] = this.parentGender;
    data['parent_image'] = this.parentImage;
    data['parent_name'] = this.parentName;
    data['parent_useridname'] = this.parentUseridname;
    return data;
  }
}
