import 'package:happsales_crm/database/models/BaseEntity.dart';

class EmailManualTemplateBase extends BaseEntity {
  String? _emailManualTemplateID;
  String? _emailManualTemplateCode;
  String? _emailManualTemplateName;
  String? _emailTemplateType;
  String? _subject;
  String? _mailBody;
  String? _fromEmail;
  String? _toEmail;
  String? _ccEmail;
  String? _emailType;
  String? _isSystemDefined;
  String? _createdOn;
  String? _createdBy;
  String? _modifiedOn;
  String? _modifiedBy;
  String? _isActive;
  String? _uid;
  String? _appUserID;
  String? _appUserGroupID;
  String? _isDeleted;
  String? _appUserName;
  String? _appUserGroupName;

  EmailManualTemplateBase();

  String? get emailManualTemplateID => _emailManualTemplateID;
  String? get emailManualTemplateCode => _emailManualTemplateCode;
  String? get emailManualTemplateName => _emailManualTemplateName;
  String? get emailTemplateType => _emailTemplateType;
  String? get subject => _subject;
  String? get mailBody => _mailBody;
  String? get fromEmail => _fromEmail;
  String? get toEmail => _toEmail;
  String? get ccEmail => _ccEmail;
  String? get emailType => _emailType;
  String? get isSystemDefined => _isSystemDefined;
  String? get createdOn => _createdOn;
  String? get createdBy => _createdBy;
  String? get modifiedOn => _modifiedOn;
  String? get modifiedBy => _modifiedBy;
  String? get isActive => _isActive;
  String? get uid => _uid;
  String? get appUserID => _appUserID;
  String? get appUserGroupID => _appUserGroupID;
  String? get isDeleted => _isDeleted;
  String? get appUserName => _appUserName;
  String? get appUserGroupName => _appUserGroupName;

  set emailManualTemplateID(String? value) {
  _emailManualTemplateID = value;
}

set emailManualTemplateCode(String? value) {
  _emailManualTemplateCode = value;
}

set emailManualTemplateName(String? value) {
  _emailManualTemplateName = value;
}

set emailTemplateType(String? value) {
  _emailTemplateType = value;
}

set subject(String? value) {
  _subject = value;
}

set mailBody(String? value) {
  _mailBody = value;
}

set fromEmail(String? value) {
  _fromEmail = value;
}

set toEmail(String? value) {
  _toEmail = value;
}

set ccEmail(String? value) {
  _ccEmail = value;
}

set emailType(String? value) {
  _emailType = value;
}

set isSystemDefined(String? value) {
  _isSystemDefined = value;
}

set createdOn(String? value) {
  _createdOn = value;
}

set createdBy(String? value) {
  _createdBy = value;
}

set modifiedOn(String? value) {
  _modifiedOn = value;
}

set modifiedBy(String? value) {
  _modifiedBy = value;
}

set isActive(String? value) {
  _isActive = value;
}

set uid(String? value) {
  _uid = value;
}

set appUserID(String? value) {
  _appUserID = value;
}

set appUserGroupID(String? value) {
  _appUserGroupID = value;
}

set isDeleted(String? value) {
  _isDeleted = value;
}

set appUserName(String? value) {
  _appUserName = value;
}

set appUserGroupName(String? value) {
  _appUserGroupName = value;
}


  EmailManualTemplateBase.fromMap(Map<String, dynamic> map)
      : _emailManualTemplateID = map['EmailManualTemplateID'],
        _emailManualTemplateCode = map['EmailManualTemplateCode'],
        _emailManualTemplateName = map['EmailManualTemplateName'],
        _emailTemplateType = map['EmailTemplateType'],
        _subject = map['Subject'],
        _mailBody = map['MailBody'],
        _fromEmail = map['FromEmail'],
        _toEmail = map['ToEmail'],
        _ccEmail = map['CcEmail'],
        _emailType = map['EMailType'],
        _isSystemDefined = map['IsSystemDefined'],
        _createdOn = map['CreatedOn'],
        _createdBy = map['CreatedBy'],
        _modifiedOn = map['ModifiedOn'],
        _modifiedBy = map['ModifiedBy'],
        _isActive = map['IsActive'],
        _uid = map['Uid'],
        _appUserID = map['AppUserID'],
        _appUserGroupID = map['AppUserGroupID'],
        _isDeleted = map['IsDeleted'],
        _appUserName = map['AppUserName'],
        _appUserGroupName = map['AppUserGroupName'];

  Map<String, dynamic> toMap() {
    return {
      'EmailManualTemplateID': _emailManualTemplateID,
      'EmailManualTemplateCode': _emailManualTemplateCode,
      'EmailManualTemplateName': _emailManualTemplateName,
      'EmailTemplateType': _emailTemplateType,
      'Subject': _subject,
      'MailBody': _mailBody,
      'FromEmail': _fromEmail,
      'ToEmail': _toEmail,
      'CcEmail': _ccEmail,
      'EMailType': _emailType,
      'IsSystemDefined': _isSystemDefined,
      'CreatedOn': _createdOn,
      'CreatedBy': _createdBy,
      'ModifiedOn': _modifiedOn,
      'ModifiedBy': _modifiedBy,
      'IsActive': _isActive,
      'Uid': _uid,
      'AppUserID': _appUserID,
      'AppUserGroupID': _appUserGroupID,
      'IsDeleted': _isDeleted,
      'AppUserName': _appUserName,
      'AppUserGroupName': _appUserGroupName,
    };
  }
}
