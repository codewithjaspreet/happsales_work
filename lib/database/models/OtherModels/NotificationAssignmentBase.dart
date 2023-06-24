import 'package:happsales_crm/database/models/BaseEntity.dart';

class NotificationAssignmentBase extends BaseEntity {
  String? _notificationAssignmentID;
  String? _notificationAssignmentCode;
  String? _notificationAssignmentTitle;
  String? _notificationID;
  String? _appUserID;
  String? _createdBy;
  String? _createdOn;
  String? _modifiedBy;
  String? _modifiedOn;
  String? _deviceIdentifier;
  String? _referenceIdentifier;
  String? _location;
  String? _isActive;
  String? _uid;
  String? _appUserGroupID;
  String? _isArchived;
  String? _isDeleted;
  String? _notificationTitle;
  String? _appUserName;
  String? _appUserGroupName;


NotificationAssignmentBase();
  String? get notificationAssignmentID => _notificationAssignmentID;
  set notificationAssignmentID(String? value) {
    _notificationAssignmentID = value;
  }

  String? get notificationAssignmentCode => _notificationAssignmentCode;
  set notificationAssignmentCode(String? value) {
    _notificationAssignmentCode = value;
  }

  String? get notificationAssignmentTitle => _notificationAssignmentTitle;
  set notificationAssignmentTitle(String? value) {
    _notificationAssignmentTitle = value;
  }

  String? get notificationID => _notificationID;
  set notificationID(String? value) {
    _notificationID = value;
  }

  String? get appUserID => _appUserID;
  set appUserID(String? value) {
    _appUserID = value;
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

  String? get deviceIdentifier => _deviceIdentifier;
  set deviceIdentifier(String? value) {
    _deviceIdentifier = value;
  }

  String? get referenceIdentifier => _referenceIdentifier;
  set referenceIdentifier(String? value) {
    _referenceIdentifier = value;
  }

  String? get location => _location;
  set location(String? value) {
    _location = value;
  }

  String? get isActive => _isActive;
  set isActive(String? value) {
    _isActive = value;
  }

  String? get uid => _uid;
  set uid(String? value) {
    _uid = value;
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

  String? get notificationTitle => _notificationTitle;
  set notificationTitle(String? value) {
    _notificationTitle = value;
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
      'NotificationAssignmentID': _notificationAssignmentID,
      'NotificationAssignmentCode': _notificationAssignmentCode,
      'NotificationAssignmentTitle': _notificationAssignmentTitle,
      'NotificationID': _notificationID,
      'AppUserID': _appUserID,
      'CreatedBy': _createdBy,
      'CreatedOn': _createdOn,
      'ModifiedBy': _modifiedBy,
      'ModifiedOn': _modifiedOn,
      'DeviceIdentifier': _deviceIdentifier,
      'ReferenceIdentifier': _referenceIdentifier,
      'Location': _location,
      'IsActive': _isActive,
      'Uid': _uid,
      'AppUserGroupID': _appUserGroupID,
      'IsArchived': _isArchived,
      'IsDeleted': _isDeleted,
      'NotificationTitle': _notificationTitle,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }

  NotificationAssignmentBase.fromMapObject(Map<String, dynamic> map) {
    _notificationAssignmentID = map['NotificationAssignmentID'];
    _notificationAssignmentCode = map['NotificationAssignmentCode'];
    _notificationAssignmentTitle = map['NotificationAssignmentTitle'];
    _notificationID = map['NotificationID'];
    _appUserID = map['AppUserID'];
    _createdBy = map['CreatedBy'];
    _createdOn = map['CreatedOn'];
    _modifiedBy = map['ModifiedBy'];
    _modifiedOn = map['ModifiedOn'];
    _deviceIdentifier = map['DeviceIdentifier'];
    _referenceIdentifier = map['ReferenceIdentifier'];
    _location = map['Location'];
    _isActive = map['IsActive'];
    _uid = map['Uid'];
    _appUserGroupID = map['AppUserGroupID'];
    _isArchived = map['IsArchived'];
    _isDeleted = map['IsDeleted'];
    _notificationTitle = map['NotificationTitle'];
    _appUserName = map['AppUserName'];
    _appUserGroupName = map['AppUserGroupName'];

  }
}
