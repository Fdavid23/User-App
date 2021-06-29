class SupportTicketModel {
  int _id;
  int _customerId;
  String _subject;
  String _type;
  String _priority;
  String _description;
  String _reply;
  int _status;
  String _createdAt;
  String _updatedAt;

  SupportTicketModel(
      {int id,
        int customerId,
        String subject,
        String type,
        String priority,
        String description,
        String reply,
        int status,
        String createdAt,
        String updatedAt}) {
    this._id = id;
    this._customerId = customerId;
    this._subject = subject;
    this._type = type;
    this._priority = priority;
    this._description = description;
    this._reply = reply;
    this._status = status;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int get id => _id;
  int get customerId => _customerId;
  String get subject => _subject;
  String get type => _type;
  String get priority => _priority;
  String get description => _description;
  String get reply => _reply;
  int get status => _status;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  SupportTicketModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _customerId = json['customer_id'];
    _subject = json['subject'];
    _type = json['type'];
    _priority = json['priority'];
    _description = json['description'];
    _reply = json['reply'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['customer_id'] = this._customerId;
    data['subject'] = this._subject;
    data['type'] = this._type;
    data['priority'] = this._priority;
    data['description'] = this._description;
    data['reply'] = this._reply;
    data['status'] = this._status;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}
