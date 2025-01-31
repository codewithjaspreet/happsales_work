

 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/FinancialYear.dart';
import '../DataBaseHandler.dart';

class FinancialYearDataHandlerBase {

     static Future<List<FinancialYear>> GetFinancialYearRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
        List<FinancialYear> dataList =[];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_FINANCIALYEAR} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_FINANCIALYEAR_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FINANCIALYEAR_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FINANCIALYEAR_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_FINANCIALYEAR_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARNAME} LIKE '%$searchString%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_FinancialYear_Columns.KEY_FINANCIALYEAR_FINANCIALYEARNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT " + startRowIndex.toString()}," + pageSize.toString();


            final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {

                    FinancialYear dataItem = new FinancialYear();

                    dataItem.financialYearID = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARID];
                    dataItem.financialYearCode = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARCODE];
                    dataItem.financialYearName = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARNAME];
                    dataItem.actualFinancialYear = element[ColumnsBase.KEY_FINANCIALYEAR_ACTUALFINANCIALYEAR];
                    dataItem.financialYearStartDate = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARSTARTDATE];
                    dataItem.financialYearEndDate = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARENDDATE];

                    dataItem.createdBy = element[ColumnsBase.KEY_FINANCIALYEAR_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_FINANCIALYEAR_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_FINANCIALYEAR_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_FINANCIALYEAR_MODIFIEDON];
                    dataItem.isActive = element[ColumnsBase.KEY_FINANCIALYEAR_ISACTIVE];
                    dataItem.uid  = element[ColumnsBase.KEY_FINANCIALYEAR_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_FINANCIALYEAR_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_FINANCIALYEAR_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_FINANCIALYEAR_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_FINANCIALYEAR_ISDELETED];
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
      
        } catch ( ex) {
            Globals.handleException( "FinancialYearDataHandlerBase:GetFinancialYearRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<FinancialYear>> GetFinancialYearRecords(DatabaseHandler databaseHandler,  String searchString) async{
        List<FinancialYear> dataList =[];
        try {
            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_FINANCIALYEAR} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_FINANCIALYEAR_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FINANCIALYEAR_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FINANCIALYEAR_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_FINANCIALYEAR_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length> 0)
                selectQuery += " AND A.${ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARNAME} LIKE '$searchString%'";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARNAME} COLLATE NOCASE ASC ";

            
            final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {

                    FinancialYear dataItem = new FinancialYear();

                    dataItem.financialYearID = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARID];
                    dataItem.financialYearCode = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARCODE];
                    dataItem.financialYearName = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARNAME];
                    dataItem.actualFinancialYear = element[ColumnsBase.KEY_FINANCIALYEAR_ACTUALFINANCIALYEAR];
                    dataItem.financialYearStartDate = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARSTARTDATE];
                    dataItem.financialYearEndDate = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARENDDATE];

                    dataItem.createdBy = element[ColumnsBase.KEY_FINANCIALYEAR_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_FINANCIALYEAR_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_FINANCIALYEAR_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_FINANCIALYEAR_MODIFIEDON];
                    dataItem.isActive = element[ColumnsBase.KEY_FINANCIALYEAR_ISACTIVE];
                    dataItem.uid  = element[ColumnsBase.KEY_FINANCIALYEAR_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_FINANCIALYEAR_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_FINANCIALYEAR_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_FINANCIALYEAR_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_FINANCIALYEAR_ISDELETED];
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
        } catch ( ex) {
            Globals.handleException( "FinancialYearDataHandlerBase:GetFinancialYearRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<FinancialYear?> GetFinancialYearRecord(DatabaseHandler databaseHandler,  String id) async{
        FinancialYear ?dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_FINANCIALYEAR} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_FINANCIALYEAR_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

            final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {

                    FinancialYear dataItem = new FinancialYear();

                    dataItem.financialYearID = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARID];
                    dataItem.financialYearCode = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARCODE];
                    dataItem.financialYearName = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARNAME];
                    dataItem.actualFinancialYear = element[ColumnsBase.KEY_FINANCIALYEAR_ACTUALFINANCIALYEAR];
                    dataItem.financialYearStartDate = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARSTARTDATE];
                    dataItem.financialYearEndDate = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARENDDATE];

                    dataItem.createdBy = element[ColumnsBase.KEY_FINANCIALYEAR_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_FINANCIALYEAR_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_FINANCIALYEAR_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_FINANCIALYEAR_MODIFIEDON];
                    dataItem.isActive = element[ColumnsBase.KEY_FINANCIALYEAR_ISACTIVE];
                    dataItem.uid  = element[ColumnsBase.KEY_FINANCIALYEAR_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_FINANCIALYEAR_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_FINANCIALYEAR_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_FINANCIALYEAR_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_FINANCIALYEAR_ISDELETED];
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
        } catch ( ex) {
            Globals.handleException( "FinancialYearDataHandlerBase:GetFinancialYearRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<FinancialYear?> GetMasterFinancialYearRecord(DatabaseHandler databaseHandler,  String id) async{
        FinancialYear? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_FINANCIALYEAR} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_FINANCIALYEAR_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {

                    FinancialYear dataItem = new FinancialYear();

                    dataItem.financialYearID = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARID];
                    dataItem.financialYearCode = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARCODE];
                    dataItem.financialYearName = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARNAME];
                    dataItem.actualFinancialYear = element[ColumnsBase.KEY_FINANCIALYEAR_ACTUALFINANCIALYEAR];
                    dataItem.financialYearStartDate = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARSTARTDATE];
                    dataItem.financialYearEndDate = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARENDDATE];

                    dataItem.createdBy = element[ColumnsBase.KEY_FINANCIALYEAR_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_FINANCIALYEAR_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_FINANCIALYEAR_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_FINANCIALYEAR_MODIFIEDON];
                    dataItem.isActive = element[ColumnsBase.KEY_FINANCIALYEAR_ISACTIVE];
                    dataItem.uid  = element[ColumnsBase.KEY_FINANCIALYEAR_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_FINANCIALYEAR_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_FINANCIALYEAR_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_FINANCIALYEAR_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_FINANCIALYEAR_ISDELETED];
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
        } catch ( ex) {
            Globals.handleException( "FinancialYearDataHandlerBase:GetMasterFinancialYearRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddFinancialYearRecord(DatabaseHandler databaseHandler,  FinancialYear dataItem) async{
        int id = 0;
        try {
          final db=  await databaseHandler.database;
          var values = <String, dynamic>{};
  
  if (dataItem.financialYearID != null && dataItem.financialYearID != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARID] = dataItem.financialYearID;
  if (dataItem.financialYearCode != null && dataItem.financialYearCode != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARCODE] = dataItem.financialYearCode;
  if (dataItem.financialYearName != null && dataItem.financialYearName != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARNAME] = dataItem.financialYearName;
  if (dataItem.actualFinancialYear != null && dataItem.actualFinancialYear != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_ACTUALFINANCIALYEAR] = dataItem.actualFinancialYear;
  if (dataItem.financialYearStartDate != null && dataItem.financialYearStartDate != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARSTARTDATE] = dataItem.financialYearStartDate;
  if (dataItem.financialYearEndDate != null && dataItem.financialYearEndDate != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARENDDATE] = dataItem.financialYearEndDate;
  if (dataItem.createdBy != null && dataItem.createdBy != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_CREATEDBY] = dataItem.createdBy;
  if (dataItem.createdOn != null && dataItem.createdOn != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_CREATEDON] = dataItem.createdOn;
  if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_MODIFIEDBY] = dataItem.modifiedBy;
  if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_MODIFIEDON] = dataItem.modifiedOn;
  if (dataItem.isActive != null && dataItem.isActive != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_ISACTIVE] = dataItem.isActive;
  if (dataItem.uid != null && dataItem.uid != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_UID] = dataItem.uid;
  if (dataItem.appUserID != null && dataItem.appUserID != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_APPUSERID] = dataItem.appUserID;
  if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_APPUSERGROUPID] = dataItem.appUserGroupID;
  if (dataItem.isArchived != null && dataItem.isArchived != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_ISARCHIVED] = dataItem.isArchived;
  if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_ISDELETED] = dataItem.isDeleted;
  if (dataItem.id != null && dataItem.id != "null")
    values[ColumnsBase.KEY_ID] = dataItem.id;
  if (dataItem.isDirty != null && dataItem.isDirty != "null")
    values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
  if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null")
    values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
  if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null")
    values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
  if (dataItem.downSyncMessage != null && dataItem.downSyncMessage != "null")
    values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
  if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != "null")
    values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
  if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != "null")
    values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
  if (dataItem.createdByUser != null && dataItem.createdByUser != "null")
    values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
  if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null")
    values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
  if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null")
    values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
  
  values[ColumnsBase.KEY_UPSYNCINDEX] = 0;
  values[ColumnsBase.KEY_ISACTIVE] = "true";
  values[ColumnsBase.KEY_ISDELETED] = "false";


            id = await db.insert(TablesBase.TABLE_FINANCIALYEAR, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddFinancialYearRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateFinancialYearRecord(DatabaseHandler databaseHandler,  String id1, FinancialYear dataItem)async {
        int id = 0;
        try {
          final db =    await   databaseHandler.database;
          var values = <String, dynamic>{};
  
  if (dataItem.financialYearID != null && dataItem.financialYearID != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARID] = dataItem.financialYearID;
  if (dataItem.financialYearCode != null && dataItem.financialYearCode != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARCODE] = dataItem.financialYearCode;
  if (dataItem.financialYearName != null && dataItem.financialYearName != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARNAME] = dataItem.financialYearName;
  if (dataItem.actualFinancialYear != null && dataItem.actualFinancialYear != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_ACTUALFINANCIALYEAR] = dataItem.actualFinancialYear;
  if (dataItem.financialYearStartDate != null && dataItem.financialYearStartDate != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARSTARTDATE] = dataItem.financialYearStartDate;
  if (dataItem.financialYearEndDate != null && dataItem.financialYearEndDate != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARENDDATE] = dataItem.financialYearEndDate;
  if (dataItem.createdBy != null && dataItem.createdBy != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_CREATEDBY] = dataItem.createdBy;
  if (dataItem.createdOn != null && dataItem.createdOn != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_CREATEDON] = dataItem.createdOn;
  if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_MODIFIEDBY] = dataItem.modifiedBy;
  if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_MODIFIEDON] = dataItem.modifiedOn;
  if (dataItem.isActive != null && dataItem.isActive != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_ISACTIVE] = dataItem.isActive;
  if (dataItem.uid != null && dataItem.uid != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_UID] = dataItem.uid;
  if (dataItem.appUserID != null && dataItem.appUserID != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_APPUSERID] = dataItem.appUserID;
  if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_APPUSERGROUPID] = dataItem.appUserGroupID;
  if (dataItem.isArchived != null && dataItem.isArchived != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_ISARCHIVED] = dataItem.isArchived;
  if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
    values[ColumnsBase.KEY_FINANCIALYEAR_ISDELETED] = dataItem.isDeleted;
  if (dataItem.id != null && dataItem.id != "null")
    values[ColumnsBase.KEY_ID] = dataItem.id;
  if (dataItem.isDirty != null && dataItem.isDirty != "null")
    values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
  if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null")
    values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
  if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null")
    values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
  if (dataItem.downSyncMessage != null && dataItem.downSyncMessage != "null")
    values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
  if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != "null")
    values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
  if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != "null")
    values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
  if (dataItem.createdByUser != null && dataItem.createdByUser != "null")
    values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
  if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null")
    values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
  if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null")
    values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;

    if(dataItem.upSyncIndex != null && dataItem.upSyncIndex != "null"){

      values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;
    }

            id = await db.update(TablesBase.TABLE_FINANCIALYEAR, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateFinancialYearRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteFinancialYearRecord(DatabaseHandler databaseHandler,  String id1) async{
        int id = 0;
        try {
            final db = await  databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_FINANCIALYEAR, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteFinancialYearRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARID}";
            selectQuery += " FROM ${TablesBase.TABLE_FINANCIALYEAR} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

          final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        serverId = result[0]
            [ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONID];
      }
            //db.close();
        } catch ( ex) {
            Globals.handleException( "FinancialYearDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_FINANCIALYEAR} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARID} = $id";

             final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        localId = result[0][ColumnsBase.KEY_ID];
      }
        } catch ( ex) {
            Globals.handleException( "FinancialYearDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<FinancialYear>> GetFinancialYearUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) async{
        List<FinancialYear> dataList =[];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_FINANCIALYEAR} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_FINANCIALYEAR} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_FINANCIALYEAR} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            }
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_FINANCIALYEAR_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

          final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {

                    FinancialYear dataItem = new FinancialYear();

                    dataItem.financialYearID = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARID];
                    dataItem.financialYearCode = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARCODE];
                    dataItem.financialYearName = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARNAME];
                    dataItem.actualFinancialYear = element[ColumnsBase.KEY_FINANCIALYEAR_ACTUALFINANCIALYEAR];
                    dataItem.financialYearStartDate = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARSTARTDATE];
                    dataItem.financialYearEndDate = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARENDDATE];

                    dataItem.createdBy = element[ColumnsBase.KEY_FINANCIALYEAR_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_FINANCIALYEAR_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_FINANCIALYEAR_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_FINANCIALYEAR_MODIFIEDON];
                    dataItem.isActive = element[ColumnsBase.KEY_FINANCIALYEAR_ISACTIVE];
                    dataItem.uid  = element[ColumnsBase.KEY_FINANCIALYEAR_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_FINANCIALYEAR_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_FINANCIALYEAR_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_FINANCIALYEAR_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_FINANCIALYEAR_ISDELETED];
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
            //db.close();
        } catch ( ex) {
            Globals.handleException( "FinancialYearDataHandlerBase:GetFinancialYearUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<FinancialYear?> GetFinancialYearRecordByUid(DatabaseHandler databaseHandler,  String uid) async{
        FinancialYear? dataItem ;
        try
        {

			String selectQuery = 	"SELECT A.* " ;
		selectQuery += " FROM ${TablesBase.TABLE_FINANCIALYEAR} A "; 
			selectQuery += " WHERE A.${ColumnsBase.KEY_FINANCIALYEAR_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
			//selectQuery += " AND A." + ColumnsBase.KEY_FINANCIALYEAR_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

           final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {

                    FinancialYear dataItem = new FinancialYear();

                    dataItem.financialYearID = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARID];
                    dataItem.financialYearCode = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARCODE];
                    dataItem.financialYearName = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARNAME];
                    dataItem.actualFinancialYear = element[ColumnsBase.KEY_FINANCIALYEAR_ACTUALFINANCIALYEAR];
                    dataItem.financialYearStartDate = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARSTARTDATE];
                    dataItem.financialYearEndDate = element[ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARENDDATE];

                    dataItem.createdBy = element[ColumnsBase.KEY_FINANCIALYEAR_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_FINANCIALYEAR_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_FINANCIALYEAR_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_FINANCIALYEAR_MODIFIEDON];
                    dataItem.isActive = element[ColumnsBase.KEY_FINANCIALYEAR_ISACTIVE];
                    dataItem.uid  = element[ColumnsBase.KEY_FINANCIALYEAR_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_FINANCIALYEAR_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_FINANCIALYEAR_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_FINANCIALYEAR_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_FINANCIALYEAR_ISDELETED];
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
        }
        catch( ex)
        {
	    Globals.handleException( "FinancialYearDataHandlerBase:GetFinancialYearRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}