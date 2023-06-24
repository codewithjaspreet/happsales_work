import 'package:happsales_crm/database/models/BaseEntity.dart';

class NotificationBase extends BaseEntity {
  String? _notificationID;
  String? _notificationCode;
  String? _notificationTitle;
  String? _notificationDetails;
  String? _notificationDate;
  String? _sendToAll;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isArchived;
  String? _isDeleted;
  String? _appUserName;
  String? _appUserGroupName;

NotificationBase();
  String? get notificationID => _notificationID;
  set notificationID(String? value) {
    _notificationID = value;
  }

  String? get notificationCode => _notificationCode;
  set notificationCode(String? value) {
    _notificationCode = value;
  }

  String? get notificationTitle => _notificationTitle;
  set notificationTitle(String? value) {
    _notificationTitle = value;
  }

  String? get notificationDetails => _notificationDetails;
  set notificationDetails(String? value) {
    _notificationDetails = value;
  }

  String? get notificationDate => _notificationDate;
  set notificationDate(String? value) {
    _notificationDate = value;
  }

  String? get sendToAll => _sendToAll;
  set sendToAll(String? value) {
    _sendToAll = value;
  }

  String? get createdBy => _createdBy;
  set createdBy(String? value) {
    _createdBy = value;
  }

  String? get createdOn => _createdOn;
  set createdOn(String? value) {
    _createdOn = value;
  }

  String? get modifiedBy => _modifiedBy;
  set modifiedBy(String? value) {
    _modifiedBy = value;
  }

  String? get modifiedOn => _modifiedOn;
  set modifiedOn(String? value) {
    _modifiedOn = value;
  }

  String? get isActive => _isActive;
  set isActive(String? value) {
    _isActive = value;
  }

  String? get uid => _uid;
  set uid(String? value) {
    _uid = value;
  }

  String? get appUserID => _appUserID;
  set appUserID(String? value) {
    _appUserID = value;
  }

  String? get appUserGroupID => _appUserGroupID;
  set appUserGroupID(String? value) {
    _appUserGroupID = value;
  }

  String? get isArchived => _isArchived;
  set isArchived(String? value) {
    _isArchived = value;
  }

  String? get isDeleted => _isDeleted;
  set isDeleted(String? value) {
    _isDeleted = value;
  }

  String? get appUserName => _appUserName;
  set appUserName(String? value) {
    _appUserName = value;
  }

  String? get appUserGroupName => _appUserGroupName;
  set appUserGroupName(String? value) {
    _appUserGroupName = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'NotificationID': _notificationID,
      'NotificationCode': _notificationCode,
      'NotificationTitle': _notificationTitle,
      'NotificationDetails': _notificationDetails,
      'NotificationDate': _notificationDate,
      'SendToAll': _sendToAll,
      'CreatedBy': _createdBy,
      'CreatedOn': _createdOn,
      'ModifiedBy': _modifiedBy,
      'ModifiedOn': _modifiedOn,
      'IsActive': _isActive,
      'Uid': _uid,
      'AppUserID': _appUserID,
      'AppUserGroupID': _appUserGroupID,
      'IsArchived': _isArchived,
      'IsDeleted': _isDeleted,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }

  NotificationBase.fromMapObject(Map<String, dynamic> map) {
    _notificationID = map['NotificationID'];
    _notificationCode = map['NotificationCode'];
    _notificationTitle = map['NotificationTitle'];
    _notificationDetails = map['NotificationDetails'];
    _notificationDate = map['NotificationDate'];
    _sendToAll = map['SendToAll'];
    _createdBy = map['CreatedBy'];
    _createdOn = map['CreatedOn'];
    _modifiedBy = map['ModifiedBy'];
    _modifiedOn = map['ModifiedOn'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserID = map['AppUserID'];
    _appUserGroupID = map['AppUserGroupID'];
    _isArchived = map['IsArchived'];
    _isDeleted = map['IsDeleted'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];

  }
}
