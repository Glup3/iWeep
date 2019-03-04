class Alerts {
  List<Alert> alert;

  Alerts({this.alert});

  Alerts.fromJson(Map<String, dynamic> json) {
    if (json['alert'] != null) {
      alert = new List<Alert>();
      json['alert'].forEach((v) {
        alert.add(new Alert.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.alert != null) {
      data['alert'] = this.alert.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Alert {
  bool active;
  int hour;
  int minute;
  String method;
  Days days;

  Alert({this.active, this.hour, this.minute, this.method, this.days});

  Alert.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    hour = json['hour'];
    minute = json['minute'];
    method = json['method'];
    days = json['days'] != null ? new Days.fromJson(json['days']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['hour'] = this.hour;
    data['minute'] = this.minute;
    data['method'] = this.method;
    if (this.days != null) {
      data['days'] = this.days.toJson();
    }
    return data;
  }
}

class Days {
  bool monday;
  bool tuesday;
  bool wednesday;
  bool thursday;
  bool friday;
  bool saturday;
  bool sunday;

  Days(
      {this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.sunday});

  Days.fromJson(Map<String, dynamic> json) {
    monday = json['monday'];
    tuesday = json['tuesday'];
    wednesday = json['wednesday'];
    thursday = json['thursday'];
    friday = json['friday'];
    saturday = json['saturday'];
    sunday = json['sunday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['monday'] = this.monday;
    data['tuesday'] = this.tuesday;
    data['wednesday'] = this.wednesday;
    data['thursday'] = this.thursday;
    data['friday'] = this.friday;
    data['saturday'] = this.saturday;
    data['sunday'] = this.sunday;
    return data;
  }
}
