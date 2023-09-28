class ParentProfileDataModel {
  String? parentDOB;
  String? parentPostalCode;
  String? parentStreetAddress;
  String? parentAbout;
  String? parentAge;
  String? parentCity;
  String? parentCountry;
  String? parentEmail;
  String? parentGender;
  String? parentImage;
  String? parentName;
  String? parentPhone;
  String? parentState;
  String? parentUseridname;

  ParentProfileDataModel(
      {this.parentDOB,
      this.parentPostalCode,
      this.parentStreetAddress,
      this.parentAbout,
      this.parentAge,
      this.parentCity,
      this.parentCountry,
      this.parentEmail,
      this.parentGender,
      this.parentImage,
      this.parentName,
      this.parentPhone,
      this.parentState,
      this.parentUseridname});

  ParentProfileDataModel.fromJson(Map<String, dynamic> json) {
    parentDOB = json['parent_DOB'];
    parentPostalCode = json['parent_PostalCode'];
    parentStreetAddress = json['parent_StreetAddress'];
    parentAbout = json['parent_about'];
    parentAge = json['parent_age'];
    parentCity = json['parent_city'];
    parentCountry = json['parent_country'];
    parentEmail = json['parent_email'];
    parentGender = json['parent_gender'];
    parentImage = json['parent_image'];
    parentName = json['parent_name'];
    parentPhone = json['parent_phone'];
    parentState = json['parent_state'];
    parentUseridname = json['parent_useridname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parent_DOB'] = this.parentDOB;
    data['parent_PostalCode'] = this.parentPostalCode;
    data['parent_StreetAddress'] = this.parentStreetAddress;
    data['parent_about'] = this.parentAbout;
    data['parent_age'] = this.parentAge;
    data['parent_city'] = this.parentCity;
    data['parent_country'] = this.parentCountry;
    data['parent_email'] = this.parentEmail;
    data['parent_gender'] = this.parentGender;
    data['parent_image'] = this.parentImage;
    data['parent_name'] = this.parentName;
    data['parent_phone'] = this.parentPhone;
    data['parent_state'] = this.parentState;
    data['parent_useridname'] = this.parentUseridname;
    return data;
  }
}
