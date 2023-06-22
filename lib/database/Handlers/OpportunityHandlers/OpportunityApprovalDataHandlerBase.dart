import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/Columns.dart';
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OpportunityModels/OpportunityApproval.dart';
import '../DataBaseHandler.dart';

class OpportunityApprovalDataHandlerBase {
  static Future<List<OpportunityApproval>> GetOpportunityApprovalRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<OpportunityApproval> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery =
          "SELECT A.* ,D.${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPENAME},E.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},F.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTITLE} AS ${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_PARENTOPPORTUNITYAPPROVALTITLE}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYAPPROVAL} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYAPPROVALTYPE} D ON A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} E ON A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYAPPROVAL} F ON A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_PARENTOPPORTUNITYAPPROVALID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISACTIVE},'true')) = 'true' ";
      //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_OpportunityApproval_ISARCHIVED + ",'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTITLE} LIKE '%${searchString.replaceAll("'", "''")}%'";
      }

      /* FILTER */
      /*String groups = "";
			String tags = "";
			String groupitem = "";
			for (Map.Entry<String, String> entry : filterHashMap.entrySet()) {
				String key1 = entry.getKey();
				String value1 = entry.getValue();
				if (entry.getKey().equals("XXXXX")) {
					groupitem = value1;
				} else {
					groups += (groups.equals("") ? "'" + key1 + "'" : ",'" + key1 + "'");
					tags += (tags.equals("") ? value1 : "," + value1);
				}
			}
			if (groupitem.trim().length() > 0)
				selectQuery += " AND A." + ColumnsBase.KEY_OpportunityApproval_Columns.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTITLE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += " LIMIT $startRowIndex,$pageSize";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
      for (var element in result) {
        OpportunityApproval dataItem = new OpportunityApproval();
        dataItem.opportunityApprovalID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALID];
        dataItem.opportunityApprovalCode = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALCODE];
        dataItem.opportunityApprovalTitle = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTITLE];
        dataItem.opportunityApprovalTypeID = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTYPEID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYID];
        dataItem.requestDate =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_REQUESTDATE];
        dataItem.requestDetail =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_REQUESTDETAIL];
        dataItem.isSubmitted =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISSUBMITTED];
        dataItem.parentOpportunityApprovalID = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_PARENTOPPORTUNITYAPPROVALID];
        dataItem.parentOpportunityApprovalTitle = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_PARENTOPPORTUNITYAPPROVALTITLE];
        dataItem.approvalStatus =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVALSTATUS];
        dataItem.approvalByAppUserID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVALBYAPPUSERID];
        dataItem.approvalTime =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVALTIME];
        dataItem.approverRemarks =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVERREMARKS];
        dataItem.isApprovalCompleted =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISAPPROVALCOMPLETED];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_REFERENCEIDENTIFIER];
        dataItem.location =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_LOCATION];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISDELETED];
        dataItem.opportunityApprovalTypeName = element[ColumnsBase
            .KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPENAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.opportunityApprovalTitle = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTITLE];
        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];
        dataList.add(dataItem);
      }
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "OpportunityApprovalDataHandlerBase:GetOpportunityApprovalRecordsPaged()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<OpportunityApproval>> GetOpportunityApprovalRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<OpportunityApproval> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* ,D.${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPENAME},E.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},F.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTITLE} AS ${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_PARENTOPPORTUNITYAPPROVALTITLE}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYAPPROVAL} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYAPPROVALTYPE} D ON A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} E ON A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYAPPROVAL} F ON A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_PARENTOPPORTUNITYAPPROVALID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISACTIVE},'true')) = 'true' ";
      //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_OpportunityApproval_ISARCHIVED + ",'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTITLE} LIKE '${searchString.replaceAll("'", "''")}%'";
      }
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTITLE} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
      for (var element in result) {
        OpportunityApproval dataItem = new OpportunityApproval();
        dataItem.opportunityApprovalID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALID];
        dataItem.opportunityApprovalCode = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALCODE];
        dataItem.opportunityApprovalTitle = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTITLE];
        dataItem.opportunityApprovalTypeID = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTYPEID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYID];
        dataItem.requestDate =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_REQUESTDATE];
        dataItem.requestDetail =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_REQUESTDETAIL];
        dataItem.isSubmitted =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISSUBMITTED];
        dataItem.parentOpportunityApprovalID = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_PARENTOPPORTUNITYAPPROVALID];
        dataItem.parentOpportunityApprovalTitle = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_PARENTOPPORTUNITYAPPROVALTITLE];
        dataItem.approvalStatus =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVALSTATUS];
        dataItem.approvalByAppUserID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVALBYAPPUSERID];
        dataItem.approvalTime =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVALTIME];
        dataItem.approverRemarks =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVERREMARKS];
        dataItem.isApprovalCompleted =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISAPPROVALCOMPLETED];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_REFERENCEIDENTIFIER];
        dataItem.location =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_LOCATION];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISDELETED];
        dataItem.opportunityApprovalTypeName = element[ColumnsBase
            .KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPENAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.opportunityApprovalTitle = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTITLE];
        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];
        dataList.add(dataItem);
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityApprovalDataHandlerBase:GetOpportunityApprovalRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<OpportunityApproval?> GetOpportunityApprovalRecord(
      DatabaseHandler databaseHandler, String id) async {
    OpportunityApproval? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,D.${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPENAME},E.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},F.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTITLE} AS ${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_PARENTOPPORTUNITYAPPROVALTITLE}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYAPPROVAL} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYAPPROVALTYPE} D ON A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} E ON A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYAPPROVAL} F ON A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_PARENTOPPORTUNITYAPPROVALID} = F.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
      for (var element in result) {
        OpportunityApproval dataItem = new OpportunityApproval();
        dataItem.opportunityApprovalID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALID];
        dataItem.opportunityApprovalCode = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALCODE];
        dataItem.opportunityApprovalTitle = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTITLE];
        dataItem.opportunityApprovalTypeID = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTYPEID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYID];
        dataItem.requestDate =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_REQUESTDATE];
        dataItem.requestDetail =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_REQUESTDETAIL];
        dataItem.isSubmitted =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISSUBMITTED];
        dataItem.parentOpportunityApprovalID = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_PARENTOPPORTUNITYAPPROVALID];
        dataItem.parentOpportunityApprovalTitle = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_PARENTOPPORTUNITYAPPROVALTITLE];
        dataItem.approvalStatus =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVALSTATUS];
        dataItem.approvalByAppUserID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVALBYAPPUSERID];
        dataItem.approvalTime =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVALTIME];
        dataItem.approverRemarks =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVERREMARKS];
        dataItem.isApprovalCompleted =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISAPPROVALCOMPLETED];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_REFERENCEIDENTIFIER];
        dataItem.location =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_LOCATION];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISDELETED];
        dataItem.opportunityApprovalTypeName = element[ColumnsBase
            .KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPENAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.opportunityApprovalTitle = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTITLE];
        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityApprovalDataHandlerBase:GetOpportunityApprovalRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<OpportunityApproval?> GetOpportunityApprovalRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    OpportunityApproval? dataItem;
    try {
      String selectQuery =
          "SELECT A.* ,D.${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPENAME},E.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},F.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTITLE} AS ${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_PARENTOPPORTUNITYAPPROVALTITLE}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYAPPROVAL} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYAPPROVALTYPE} D ON A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} E ON A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYAPPROVAL} F ON A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_PARENTOPPORTUNITYAPPROVALID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
      //selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
      for (var element in result) {
        OpportunityApproval dataItem = new OpportunityApproval();
        dataItem.opportunityApprovalID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALID];
        dataItem.opportunityApprovalCode = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALCODE];
        dataItem.opportunityApprovalTitle = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTITLE];
        dataItem.opportunityApprovalTypeID = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTYPEID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYID];
        dataItem.requestDate =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_REQUESTDATE];
        dataItem.requestDetail =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_REQUESTDETAIL];
        dataItem.isSubmitted =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISSUBMITTED];
        dataItem.parentOpportunityApprovalID = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_PARENTOPPORTUNITYAPPROVALID];
        dataItem.parentOpportunityApprovalTitle = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_PARENTOPPORTUNITYAPPROVALTITLE];
        dataItem.approvalStatus =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVALSTATUS];
        dataItem.approvalByAppUserID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVALBYAPPUSERID];
        dataItem.approvalTime =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVALTIME];
        dataItem.approverRemarks =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVERREMARKS];
        dataItem.isApprovalCompleted =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISAPPROVALCOMPLETED];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_REFERENCEIDENTIFIER];
        dataItem.location =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_LOCATION];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISDELETED];
        dataItem.opportunityApprovalTypeName = element[ColumnsBase
            .KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPENAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.opportunityApprovalTitle = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTITLE];
        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityApprovalDataHandlerBase:GetOpportunityApprovalRecordByUid()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<OpportunityApproval?> GetMasterOpportunityApprovalRecord(
      DatabaseHandler databaseHandler, String id) async {
    OpportunityApproval? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,D.${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPENAME},E.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},F.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTITLE} AS ${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_PARENTOPPORTUNITYAPPROVALTITLE}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYAPPROVAL} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYAPPROVALTYPE} D ON A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} E ON A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYAPPROVAL} F ON A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_PARENTOPPORTUNITYAPPROVALID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
      for (var element in result) {
        OpportunityApproval dataItem = new OpportunityApproval();
        dataItem.opportunityApprovalID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALID];
        dataItem.opportunityApprovalCode = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALCODE];
        dataItem.opportunityApprovalTitle = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTITLE];
        dataItem.opportunityApprovalTypeID = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTYPEID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYID];
        dataItem.requestDate =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_REQUESTDATE];
        dataItem.requestDetail =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_REQUESTDETAIL];
        dataItem.isSubmitted =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISSUBMITTED];
        dataItem.parentOpportunityApprovalID = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_PARENTOPPORTUNITYAPPROVALID];
        dataItem.parentOpportunityApprovalTitle = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_PARENTOPPORTUNITYAPPROVALTITLE];
        dataItem.approvalStatus =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVALSTATUS];
        dataItem.approvalByAppUserID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVALBYAPPUSERID];
        dataItem.approvalTime =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVALTIME];
        dataItem.approverRemarks =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVERREMARKS];
        dataItem.isApprovalCompleted =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISAPPROVALCOMPLETED];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_REFERENCEIDENTIFIER];
        dataItem.location =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_LOCATION];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISDELETED];
        dataItem.opportunityApprovalTypeName = element[ColumnsBase
            .KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPENAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.opportunityApprovalTitle = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTITLE];
        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityApprovalDataHandlerBase:GetMasterOpportunityApprovalRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddOpportunityApprovalRecord(
      DatabaseHandler databaseHandler, OpportunityApproval dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = new Map();

      if (dataItem.opportunityApprovalID != null &&
          dataItem.opportunityApprovalID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALID] =
            dataItem.opportunityApprovalID;
      }
      if (dataItem.opportunityApprovalCode != null &&
          dataItem.opportunityApprovalCode != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALCODE] =
            dataItem.opportunityApprovalCode;
      }
      if (dataItem.opportunityApprovalTitle != null &&
          dataItem.opportunityApprovalTitle != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTITLE] =
            dataItem.opportunityApprovalTitle;
      }
      if (dataItem.opportunityApprovalTypeID != null &&
          dataItem.opportunityApprovalTypeID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTYPEID] =
            dataItem.opportunityApprovalTypeID;
      }
      if (dataItem.opportunityID != null && dataItem.opportunityID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYID] =
            dataItem.opportunityID;
      }
      if (dataItem.requestDate != null && dataItem.requestDate != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_REQUESTDATE] =
            dataItem.requestDate;
      }
      if (dataItem.requestDetail != null && dataItem.requestDetail != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_REQUESTDETAIL] =
            dataItem.requestDetail;
      }
      if (dataItem.isSubmitted != null && dataItem.isSubmitted != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISSUBMITTED] =
            dataItem.isSubmitted;
      }
      if (dataItem.parentOpportunityApprovalID != null &&
          dataItem.parentOpportunityApprovalID != "null") {
        values[ColumnsBase
                .KEY_OPPORTUNITYAPPROVAL_PARENTOPPORTUNITYAPPROVALID] =
            dataItem.parentOpportunityApprovalID;
      }
      if (dataItem.parentOpportunityApprovalTitle != null &&
          dataItem.parentOpportunityApprovalTitle != "null") {
        values[ColumnsBase
                .KEY_OPPORTUNITYAPPROVAL_PARENTOPPORTUNITYAPPROVALTITLE] =
            dataItem.parentOpportunityApprovalTitle;
      }
      if (dataItem.approvalStatus != null &&
          dataItem.approvalStatus != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVALSTATUS] =
            dataItem.approvalStatus;
      }
      if (dataItem.approvalByAppUserID != null &&
          dataItem.approvalByAppUserID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVALBYAPPUSERID] =
            dataItem.approvalByAppUserID;
      }
      if (dataItem.approvalTime != null && dataItem.approvalTime != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVALTIME] =
            dataItem.approvalTime;
      }
      if (dataItem.approverRemarks != null &&
          dataItem.approverRemarks != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVERREMARKS] =
            dataItem.approverRemarks;
      }
      if (dataItem.isApprovalCompleted != null &&
          dataItem.isApprovalCompleted != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISAPPROVALCOMPLETED] =
            dataItem.isApprovalCompleted;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_CREATEDBY] =
            dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_CREATEDON] =
            dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.deviceIdentifier != null &&
          dataItem.deviceIdentifier != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_DEVICEIDENTIFIER] =
            dataItem.deviceIdentifier;
      }
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      }
      if (dataItem.location != null && dataItem.location != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_LOCATION] =
            dataItem.location;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISACTIVE] =
            dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPUSERID] =
            dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISARCHIVED] =
            dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISDELETED] =
            dataItem.isDeleted;
      }
      if (dataItem.id != null && dataItem.id != "null") {
        values[ColumnsBase.KEY_ID] = dataItem.id;
      }
      if (dataItem.isDirty != null && dataItem.isDirty != "null") {
        values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
      }
      if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null") {
        values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
      }
      if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null") {
        values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
      }
      if (dataItem.downSyncMessage != null &&
          dataItem.downSyncMessage != "null") {
        values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
      }
      if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != "null") {
        values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
      }
      if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != "null") {
        values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
      }
      if (dataItem.createdByUser != null && dataItem.createdByUser != "null") {
        values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
      }
      if (dataItem.modifiedByUser != null &&
          dataItem.modifiedByUser != "null") {
        values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
      }
      if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null") {
        values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
      }
      values[ColumnsBase.KEY_UPSYNCINDEX] = 0;
      values[ColumnsBase.KEY_ISACTIVE] = "true";
      values[ColumnsBase.KEY_ISDELETED] = "false";

      id = await db.insert(TablesBase.TABLE_OPPORTUNITYAPPROVAL, values);

      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:AddOpportunityApprovalRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateOpportunityApprovalRecord(
      DatabaseHandler databaseHandler,
      String id1,
      OpportunityApproval dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = new Map();

      if (dataItem.opportunityApprovalID != null &&
          dataItem.opportunityApprovalID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALID] =
            dataItem.opportunityApprovalID;
      }
      if (dataItem.opportunityApprovalCode != null &&
          dataItem.opportunityApprovalCode != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALCODE] =
            dataItem.opportunityApprovalCode;
      }
      if (dataItem.opportunityApprovalTitle != null &&
          dataItem.opportunityApprovalTitle != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTITLE] =
            dataItem.opportunityApprovalTitle;
      }
      if (dataItem.opportunityApprovalTypeID != null &&
          dataItem.opportunityApprovalTypeID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTYPEID] =
            dataItem.opportunityApprovalTypeID;
      }
      if (dataItem.opportunityID != null && dataItem.opportunityID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYID] =
            dataItem.opportunityID;
      }
      if (dataItem.requestDate != null && dataItem.requestDate != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_REQUESTDATE] =
            dataItem.requestDate;
      }
      if (dataItem.requestDetail != null && dataItem.requestDetail != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_REQUESTDETAIL] =
            dataItem.requestDetail;
      }
      if (dataItem.isSubmitted != null && dataItem.isSubmitted != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISSUBMITTED] =
            dataItem.isSubmitted;
      }
      if (dataItem.parentOpportunityApprovalID != null &&
          dataItem.parentOpportunityApprovalID != "null") {
        values[ColumnsBase
                .KEY_OPPORTUNITYAPPROVAL_PARENTOPPORTUNITYAPPROVALID] =
            dataItem.parentOpportunityApprovalID;
      }
      if (dataItem.parentOpportunityApprovalTitle != null &&
          dataItem.parentOpportunityApprovalTitle != "null") {
        values[ColumnsBase
                .KEY_OPPORTUNITYAPPROVAL_PARENTOPPORTUNITYAPPROVALTITLE] =
            dataItem.parentOpportunityApprovalTitle;
      }
      if (dataItem.approvalStatus != null &&
          dataItem.approvalStatus != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVALSTATUS] =
            dataItem.approvalStatus;
      }
      if (dataItem.approvalByAppUserID != null &&
          dataItem.approvalByAppUserID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVALBYAPPUSERID] =
            dataItem.approvalByAppUserID;
      }
      if (dataItem.approvalTime != null && dataItem.approvalTime != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVALTIME] =
            dataItem.approvalTime;
      }
      if (dataItem.approverRemarks != null &&
          dataItem.approverRemarks != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVERREMARKS] =
            dataItem.approverRemarks;
      }
      if (dataItem.isApprovalCompleted != null &&
          dataItem.isApprovalCompleted != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISAPPROVALCOMPLETED] =
            dataItem.isApprovalCompleted;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_CREATEDBY] =
            dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_CREATEDON] =
            dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.deviceIdentifier != null &&
          dataItem.deviceIdentifier != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_DEVICEIDENTIFIER] =
            dataItem.deviceIdentifier;
      }
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      }
      if (dataItem.location != null && dataItem.location != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_LOCATION] =
            dataItem.location;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISACTIVE] =
            dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPUSERID] =
            dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISARCHIVED] =
            dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISDELETED] =
            dataItem.isDeleted;
      }
      if (dataItem.id != null && dataItem.id != "null") {
        values[ColumnsBase.KEY_ID] = dataItem.id;
      }
      if (dataItem.isDirty != null && dataItem.isDirty != "null") {
        values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
      }
      if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null") {
        values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
      }
      if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null") {
        values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
      }
      if (dataItem.downSyncMessage != null &&
          dataItem.downSyncMessage != "null") {
        values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
      }
      if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != "null") {
        values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
      }
      if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != "null") {
        values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
      }
      if (dataItem.createdByUser != null && dataItem.createdByUser != "null") {
        values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
      }
      if (dataItem.modifiedByUser != null &&
          dataItem.modifiedByUser != "null") {
        values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
      }
      if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null") {
        values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
      }

      id = await db.update(TablesBase.TABLE_OPPORTUNITYAPPROVAL, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:UpdateOpportunityApprovalRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteOpportunityApprovalRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_OPPORTUNITYAPPROVAL,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:DeleteOpportunityApprovalRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<String> GetServerId(
      DatabaseHandler databaseHandler, String id) async {
    String serverId = "-1";
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALID}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYAPPROVAL} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result != null && result.length > 0) {
        serverId = result[0]
            [ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALID];
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityApprovalDataHandlerBase:GetServerId()", ex);
      throw ex;
    }
    return serverId;
  }

  static Future<String> GetLocalId(
      DatabaseHandler databaseHandler, String id) async {
    String localId = "";
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYAPPROVAL} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALID} = $id";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result != null && result.length > 0) {
        localId = result[0]
            [ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALID];
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityApprovalDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<OpportunityApproval>> GetOpportunityApprovalUpSyncRecords(
      DatabaseHandler databaseHandler, String changeType) async {
    List<OpportunityApproval> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYAPPROVAL} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
              Globals.SyncIndex.toString();
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        // ignore: prefer_interpolation_to_compose_strings
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYAPPROVAL} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
                Globals.SyncIndex.toString();
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYAPPROVAL} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
                Globals.SyncIndex.toString();
      }
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYID} IN (SELECT  ${ColumnsBase.KEY_ID} FROM ${TablesBase.TABLE_OPPORTUNITY} WHERE CAST(COALESCE(${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID},'0') AS long) > 0)";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
      for (var element in result) {
        OpportunityApproval dataItem = new OpportunityApproval();
        dataItem.opportunityApprovalID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALID];
        dataItem.opportunityApprovalCode = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALCODE];
        dataItem.opportunityApprovalTitle = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTITLE];
        dataItem.opportunityApprovalTypeID = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTYPEID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYID];
        dataItem.requestDate =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_REQUESTDATE];
        dataItem.requestDetail =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_REQUESTDETAIL];
        dataItem.isSubmitted =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISSUBMITTED];
        dataItem.parentOpportunityApprovalID = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_PARENTOPPORTUNITYAPPROVALID];
        dataItem.parentOpportunityApprovalTitle = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_PARENTOPPORTUNITYAPPROVALTITLE];
        dataItem.approvalStatus =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVALSTATUS];
        dataItem.approvalByAppUserID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVALBYAPPUSERID];
        dataItem.approvalTime =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVALTIME];
        dataItem.approverRemarks =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPROVERREMARKS];
        dataItem.isApprovalCompleted =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISAPPROVALCOMPLETED];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_REFERENCEIDENTIFIER];
        dataItem.location =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_LOCATION];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVAL_ISDELETED];
        dataItem.opportunityApprovalTypeName = element[ColumnsBase
            .KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPENAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.opportunityApprovalTitle = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVAL_OPPORTUNITYAPPROVALTITLE];
        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityApprovalDataHandlerBase:GetOpportunityApprovalUpSyncRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }
}
