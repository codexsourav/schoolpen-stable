class StudentProfileModel {
  String? _sId;
  String? _dob;
  String? _gender;
  String? _password;
  PersonalInfo? _personalInfo;
  String? _region;
  String? _role;
  String? _schoolkey;
  String? _statusDescription;
  String? _statusTitle;
  String? _userClass;
  String? _userId;
  String? _userImage;
  String? _username;

  StudentProfileModel(
      {String? sId,
      String? dob,
      String? gender,
      String? password,
      PersonalInfo? personalInfo,
      String? region,
      String? role,
      String? schoolkey,
      String? statusDescription,
      String? statusTitle,
      String? userClass,
      String? userId,
      String? userImage,
      String? username}) {
    if (sId != null) {
      _sId = sId;
    }
    if (dob != null) {
      _dob = dob;
    }
    if (gender != null) {
      _gender = gender;
    }
    if (password != null) {
      _password = password;
    }
    if (personalInfo != null) {
      _personalInfo = personalInfo;
    }
    if (region != null) {
      _region = region;
    }
    if (role != null) {
      _role = role;
    }
    if (schoolkey != null) {
      _schoolkey = schoolkey;
    }
    if (statusDescription != null) {
      _statusDescription = statusDescription;
    }
    if (statusTitle != null) {
      _statusTitle = statusTitle;
    }
    if (userClass != null) {
      _userClass = userClass;
    }
    if (userId != null) {
      _userId = userId;
    }
    if (userImage != null) {
      _userImage = userImage;
    }
    if (username != null) {
      _username = username;
    }
  }

  String? get sId => _sId;
  set sId(String? sId) => _sId = sId;
  String? get dob => _dob;
  set dob(String? dob) => _dob = dob;
  String? get gender => _gender;
  set gender(String? gender) => _gender = gender;
  String? get password => _password;
  set password(String? password) => _password = password;
  PersonalInfo? get personalInfo => _personalInfo;
  set personalInfo(PersonalInfo? personalInfo) => _personalInfo = personalInfo;
  String? get region => _region;
  set region(String? region) => _region = region;
  String? get role => _role;
  set role(String? role) => _role = role;
  String? get schoolkey => _schoolkey;
  set schoolkey(String? schoolkey) => _schoolkey = schoolkey;
  String? get statusDescription => _statusDescription;
  set statusDescription(String? statusDescription) =>
      _statusDescription = statusDescription;
  String? get statusTitle => _statusTitle;
  set statusTitle(String? statusTitle) => _statusTitle = statusTitle;
  String? get userClass => _userClass;
  set userClass(String? userClass) => _userClass = userClass;
  String? get userId => _userId;
  set userId(String? userId) => _userId = userId;
  String? get userImage => _userImage;
  set userImage(String? userImage) => _userImage = userImage;
  String? get username => _username;
  set username(String? username) => _username = username;

  StudentProfileModel.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _dob = json['dob'];
    _gender = json['gender'];
    _password = json['password'];
    _personalInfo = json['personal_info'] != null
        ? PersonalInfo.fromJson(json['personal_info'])
        : null;
    _region = json['region'];
    _role = json['role'];
    _schoolkey = json['schoolkey'];
    _statusDescription = json['status_description'];
    _statusTitle = json['status_title'];
    _userClass = json['user_class'];
    _userId = json['user_id'];
    _userImage = json['user_image'];
    _username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = _sId;
    data['dob'] = _dob;
    data['gender'] = _gender;
    data['password'] = _password;
    if (_personalInfo != null) {
      data['personal_info'] = _personalInfo!.toJson();
    }
    data['region'] = _region;
    data['role'] = _role;
    data['schoolkey'] = _schoolkey;
    data['status_description'] = _statusDescription;
    data['status_title'] = _statusTitle;
    data['user_class'] = _userClass;
    data['user_id'] = _userId;
    data['user_image'] = _userImage;
    data['username'] = _username;
    return data;
  }
}

class PersonalInfo {
  String? _about;
  Contact? _contact;

  PersonalInfo({String? about, Contact? contact}) {
    if (about != null) {
      _about = about;
    }
    if (contact != null) {
      _contact = contact;
    }
  }

  String? get about => _about;
  set about(String? about) => _about = about;
  Contact? get contact => _contact;
  set contact(Contact? contact) => _contact = contact;

  PersonalInfo.fromJson(Map<String, dynamic> json) {
    _about = json['about'];
    _contact =
        json['contact'] != null ? Contact.fromJson(json['contact']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['about'] = _about;
    if (_contact != null) {
      data['contact'] = _contact!.toJson();
    }
    return data;
  }
}

class Contact {
  Address? _address;
  String? _email;
  String? _phone;

  Contact({Address? address, String? email, String? phone}) {
    if (address != null) {
      _address = address;
    }
    if (email != null) {
      _email = email;
    }
    if (phone != null) {
      _phone = phone;
    }
  }

  Address? get address => _address;
  set address(Address? address) => _address = address;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get phone => _phone;
  set phone(String? phone) => _phone = phone;

  Contact.fromJson(Map<String, dynamic> json) {
    _address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    _email = json['email'];
    _phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (_address != null) {
      data['address'] = _address!.toJson();
    }
    data['email'] = _email;
    data['phone'] = _phone;
    return data;
  }
}

class Address {
  String? _city;
  String? _pincode;
  String? _state;
  String? _street;

  Address({String? city, String? pincode, String? state, String? street}) {
    if (city != null) {
      _city = city;
    }
    if (pincode != null) {
      _pincode = pincode;
    }
    if (state != null) {
      _state = state;
    }
    if (street != null) {
      _street = street;
    }
  }

  String? get city => _city;
  set city(String? city) => _city = city;
  String? get pincode => _pincode;
  set pincode(String? pincode) => _pincode = pincode;
  String? get state => _state;
  set state(String? state) => _state = state;
  String? get street => _street;
  set street(String? street) => _street = street;

  Address.fromJson(Map<String, dynamic> json) {
    _city = json['city'];
    _pincode = json['pincode'];
    _state = json['state'];
    _street = json['street'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['city'] = _city;
    data['pincode'] = _pincode;
    data['state'] = _state;
    data['street'] = _street;
    return data;
  }
}
