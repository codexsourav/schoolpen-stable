class TeacherProfileDataModel {
  String? sId;
  String? dob;
  String? gender;
  String? languages;
  Profile? profile;
  String? region;
  String? role;
  String? userImage;
  String? username;

  TeacherProfileDataModel(
      {this.sId,
      this.dob,
      this.gender,
      this.languages,
      this.profile,
      this.region,
      this.role,
      this.userImage,
      this.username});

  TeacherProfileDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    dob = json['dob'];
    gender = json['gender'];
    languages = json['languages'];
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    region = json['region'];
    role = json['role'];
    userImage = json['user_image'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['languages'] = this.languages;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    data['region'] = this.region;
    data['role'] = this.role;
    data['user_image'] = this.userImage;
    data['username'] = this.username;
    return data;
  }
}

class Profile {
  String? about;
  Contact? contact;
  Status? status;
  UseridnamePassword? useridnamePassword;

  Profile({this.about, this.contact, this.status, this.useridnamePassword});

  Profile.fromJson(Map<String, dynamic> json) {
    about = json['about'];
    contact =
        json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    useridnamePassword = json['useridname_password'] != null
        ? new UseridnamePassword.fromJson(json['useridname_password'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['about'] = this.about;
    if (this.contact != null) {
      data['contact'] = this.contact!.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    if (this.useridnamePassword != null) {
      data['useridname_password'] = this.useridnamePassword!.toJson();
    }
    return data;
  }
}

class Contact {
  Address? address;
  String? email;
  String? phone;

  Contact({this.address, this.email, this.phone});

  Contact.fromJson(Map<String, dynamic> json) {
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}

class Address {
  String? city;
  String? houseNo;
  String? postalCode;
  String? state;
  String? street;

  Address({this.city, this.houseNo, this.postalCode, this.state, this.street});

  Address.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    houseNo = json['house_no'];
    postalCode = json['postal_code'];
    state = json['state'];
    street = json['street'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['house_no'] = this.houseNo;
    data['postal_code'] = this.postalCode;
    data['state'] = this.state;
    data['street'] = this.street;
    return data;
  }
}

class Status {
  String? userDescription;
  String? userDesignation;

  Status({this.userDescription, this.userDesignation});

  Status.fromJson(Map<String, dynamic> json) {
    userDescription = json['user_description'];
    userDesignation = json['user_designation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_description'] = this.userDescription;
    data['user_designation'] = this.userDesignation;
    return data;
  }
}

class UseridnamePassword {
  String? password;
  String? useridName;

  UseridnamePassword({this.password, this.useridName});

  UseridnamePassword.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    useridName = json['userid_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    data['userid_name'] = this.useridName;
    return data;
  }
}
