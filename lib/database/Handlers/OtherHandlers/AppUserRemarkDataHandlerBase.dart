
import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/AppUserRemark.dart';
import '../DataBaseHandler.dart';

 class AppUserRemarkDataHandlerBase {

     static Future<List<AppUserRemark>> GetAppUserRemarkRecordsPaged(DatabaseHandler databaseHandler, String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize)async{
        List<AppUserRemark> dataList =[];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERREMARK} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_APPUSERREMARK_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERREMARK_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERREMARK_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERREMARK_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length> 0)
                selectQuery += " AND A.${ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKCODE} LIKE '%$searchString%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_AppUserRemark_Columns.KEY_APPUSERREMARK_APPUSERREMARKCODE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += " LIMIT $startRowIndex,$pageSize";


            final db = await  databaseHandler.database;

            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){

                    AppUserRemark dataItem = new AppUserRemark();
                    dataItem.appUserRemarkID = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKID];
                    dataItem.appUserRemarkCode = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKCODE];
                    dataItem.appUserRemarkDetails = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKDETAILS];
                    dataItem.appUserRemarkObject = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKOBJECT];
                    dataItem.appUserRemarkObjectID = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKOBJECTID];
                    dataItem.createdBy = element[ColumnsBase.KEY_APPUSERREMARK_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_APPUSERREMARK_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERREMARK_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERREMARK_MODIFIEDON];
                    dataItem.deviceIdentifier = element[ColumnsBase.KEY_APPUSERREMARK_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_APPUSERREMARK_REFERENCEIDENTIFIER];
                    dataItem.location = element[ColumnsBase.KEY_APPUSERREMARK_LOCATION];
                    dataItem.isActive = element[ColumnsBase.KEY_APPUSERREMARK_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_APPUSERREMARK_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_APPUSERREMARK_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERREMARK_ISDELETED];
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
            Globals.handleException( "AppUserRemarkDataHandlerBase:GetAppUserRemarkRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<AppUserRemark>> GetAppUserRemarkRecords(DatabaseHandler databaseHandler, String searchString) async{
        List<AppUserRemark> dataList = [];
        try {
            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERREMARK} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_APPUSERREMARK_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERREMARK_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERREMARK_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERREMARK_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKCODE} LIKE '$searchString%'";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKCODE} COLLATE NOCASE ASC ";
 final db = await  databaseHandler.database;

            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){

                    AppUserRemark dataItem = new AppUserRemark();
                    dataItem.appUserRemarkID = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKID];
                    dataItem.appUserRemarkCode = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKCODE];
                    dataItem.appUserRemarkDetails = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKDETAILS];
                    dataItem.appUserRemarkObject = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKOBJECT];
                    dataItem.appUserRemarkObjectID = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKOBJECTID];
                    dataItem.createdBy = element[ColumnsBase.KEY_APPUSERREMARK_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_APPUSERREMARK_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERREMARK_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERREMARK_MODIFIEDON];
                    dataItem.deviceIdentifier = element[ColumnsBase.KEY_APPUSERREMARK_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_APPUSERREMARK_REFERENCEIDENTIFIER];
                    dataItem.location = element[ColumnsBase.KEY_APPUSERREMARK_LOCATION];
                    dataItem.isActive = element[ColumnsBase.KEY_APPUSERREMARK_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_APPUSERREMARK_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_APPUSERREMARK_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERREMARK_ISDELETED];
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
            Globals.handleException( "AppUserRemarkDataHandlerBase:GetAppUserRemarkRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<AppUserRemark?> GetAppUserRemarkRecord(DatabaseHandler databaseHandler, String id) async{
        AppUserRemark? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERREMARK} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_APPUSERREMARK_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
 final db = await  databaseHandler.database;

            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){

                    AppUserRemark dataItem = new AppUserRemark();
                    dataItem.appUserRemarkID = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKID];
                    dataItem.appUserRemarkCode = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKCODE];
                    dataItem.appUserRemarkDetails = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKDETAILS];
                    dataItem.appUserRemarkObject = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKOBJECT];
                    dataItem.appUserRemarkObjectID = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKOBJECTID];
                    dataItem.createdBy = element[ColumnsBase.KEY_APPUSERREMARK_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_APPUSERREMARK_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERREMARK_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERREMARK_MODIFIEDON];
                    dataItem.deviceIdentifier = element[ColumnsBase.KEY_APPUSERREMARK_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_APPUSERREMARK_REFERENCEIDENTIFIER];
                    dataItem.location = element[ColumnsBase.KEY_APPUSERREMARK_LOCATION];
                    dataItem.isActive = element[ColumnsBase.KEY_APPUSERREMARK_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_APPUSERREMARK_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_APPUSERREMARK_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERREMARK_ISDELETED];
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
            Globals.handleException( "AppUserRemarkDataHandlerBase:GetAppUserRemarkRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<AppUserRemark?> GetMasterAppUserRemarkRecord(DatabaseHandler databaseHandler, String id)async {
        AppUserRemark ?dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERREMARK} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_APPUSERREMARK_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

            final db = await  databaseHandler.database;

            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){

                    AppUserRemark dataItem = new AppUserRemark();
                    dataItem.appUserRemarkID = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKID];
                    dataItem.appUserRemarkCode = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKCODE];
                    dataItem.appUserRemarkDetails = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKDETAILS];
                    dataItem.appUserRemarkObject = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKOBJECT];
                    dataItem.appUserRemarkObjectID = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKOBJECTID];
                    dataItem.createdBy = element[ColumnsBase.KEY_APPUSERREMARK_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_APPUSERREMARK_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERREMARK_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERREMARK_MODIFIEDON];
                    dataItem.deviceIdentifier = element[ColumnsBase.KEY_APPUSERREMARK_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_APPUSERREMARK_REFERENCEIDENTIFIER];
                    dataItem.location = element[ColumnsBase.KEY_APPUSERREMARK_LOCATION];
                    dataItem.isActive = element[ColumnsBase.KEY_APPUSERREMARK_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_APPUSERREMARK_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_APPUSERREMARK_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERREMARK_ISDELETED];
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
            Globals.handleException( "AppUserRemarkDataHandlerBase:GetMasterAppUserRemarkRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddAppUserRemarkRecord(DatabaseHandler databaseHandler, AppUserRemark dataItem)async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
           Map<String, dynamic> values = {};
if (dataItem.appUserRemarkID != null && dataItem.appUserRemarkID != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKID] = dataItem.appUserRemarkID;
}
if (dataItem.appUserRemarkCode != null && dataItem.appUserRemarkCode != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKCODE] = dataItem.appUserRemarkCode;
}
if (dataItem.appUserRemarkDetails != null && dataItem.appUserRemarkDetails != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKDETAILS] = dataItem.appUserRemarkDetails;
}
if (dataItem.appUserRemarkObject != null && dataItem.appUserRemarkObject != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKOBJECT] = dataItem.appUserRemarkObject;
}
if (dataItem.appUserRemarkObjectID != null && dataItem.appUserRemarkObjectID != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKOBJECTID] = dataItem.appUserRemarkObjectID;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.deviceIdentifier != null && dataItem.deviceIdentifier != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_DEVICEIDENTIFIER] = dataItem.deviceIdentifier;
}
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
}
if (dataItem.location != null && dataItem.location != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_LOCATION] = dataItem.location;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_ISDELETED] = dataItem.isDeleted;
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
if (dataItem.downSyncMessage != null && dataItem.downSyncMessage != "null") {
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
if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null") {
  values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
}
if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null") {
  values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
}
values[ColumnsBase.KEY_UPSYNCINDEX] = 0;
values[ColumnsBase.KEY_ISACTIVE] = "true";
values[ColumnsBase.KEY_ISDELETED] = "false";


            id = await db.insert(TablesBase.TABLE_APPUSERREMARK, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddAppUserRemarkRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateAppUserRemarkRecord(DatabaseHandler databaseHandler, String id1, AppUserRemark dataItem)async {
        int id = 0;
        try {
            final db =await  databaseHandler.database;
           Map<String, dynamic> values = {};
if (dataItem.appUserRemarkID != null && dataItem.appUserRemarkID != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKID] = dataItem.appUserRemarkID;
}
if (dataItem.appUserRemarkCode != null && dataItem.appUserRemarkCode != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKCODE] = dataItem.appUserRemarkCode;
}
if (dataItem.appUserRemarkDetails != null && dataItem.appUserRemarkDetails != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKDETAILS] = dataItem.appUserRemarkDetails;
}
if (dataItem.appUserRemarkObject != null && dataItem.appUserRemarkObject != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKOBJECT] = dataItem.appUserRemarkObject;
}
if (dataItem.appUserRemarkObjectID != null && dataItem.appUserRemarkObjectID != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKOBJECTID] = dataItem.appUserRemarkObjectID;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.deviceIdentifier != null && dataItem.deviceIdentifier != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_DEVICEIDENTIFIER] = dataItem.deviceIdentifier;
}
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
}
if (dataItem.location != null && dataItem.location != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_LOCATION] = dataItem.location;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_APPUSERREMARK_ISDELETED] = dataItem.isDeleted;
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
if (dataItem.downSyncMessage != null && dataItem.downSyncMessage != "null") {
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
if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null") {
  values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
}
if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null") {
  values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
}

            id = await db.update(TablesBase.TABLE_APPUSERREMARK, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateAppUserRemarkRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteAppUserRemarkRecord(DatabaseHandler databaseHandler, String id1)async {
        int id = 0;
        try {
            final db =  await databaseHandler.database;
            id = await  db.delete(TablesBase.TABLE_APPUSERREMARK, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteAppUserRemarkRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler, String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKID}";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERREMARK} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db = await  databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result != null && result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKID];
            }
           
        } catch ( ex) {
            Globals.handleException( "AppUserRemarkDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler, String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERREMARK} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKID} = $id";

            final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result != null && result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ID];
            }
           
        } catch ( ex) {
            Globals.handleException( "AppUserRemarkDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<AppUserRemark>> GetAppUserRemarkUpSyncRecords(DatabaseHandler databaseHandler, String changeType) async{
        List<AppUserRemark> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_APPUSERREMARK} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_APPUSERREMARK} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_APPUSERREMARK} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            }
			selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND ${ColumnsBase.KEY_APPUSERREMARK_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

            final db = await  databaseHandler.database;

            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){

                    AppUserRemark dataItem = new AppUserRemark();
                    dataItem.appUserRemarkID = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKID];
                    dataItem.appUserRemarkCode = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKCODE];
                    dataItem.appUserRemarkDetails = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKDETAILS];
                    dataItem.appUserRemarkObject = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKOBJECT];
                    dataItem.appUserRemarkObjectID = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKOBJECTID];
                    dataItem.createdBy = element[ColumnsBase.KEY_APPUSERREMARK_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_APPUSERREMARK_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERREMARK_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERREMARK_MODIFIEDON];
                    dataItem.deviceIdentifier = element[ColumnsBase.KEY_APPUSERREMARK_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_APPUSERREMARK_REFERENCEIDENTIFIER];
                    dataItem.location = element[ColumnsBase.KEY_APPUSERREMARK_LOCATION];
                    dataItem.isActive = element[ColumnsBase.KEY_APPUSERREMARK_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_APPUSERREMARK_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_APPUSERREMARK_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERREMARK_ISDELETED];
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
            Globals.handleException( "AppUserRemarkDataHandlerBase:GetAppUserRemarkUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<AppUserRemark?> GetAppUserRemarkRecordByUid(DatabaseHandler databaseHandler, String uid)async {
        AppUserRemark? dataItem ;
        try
        {

			String selectQuery = 	"SELECT A.* " ;
		selectQuery += " FROM ${TablesBase.TABLE_APPUSERREMARK} A "; 
			selectQuery += " WHERE A.${ColumnsBase.KEY_APPUSERREMARK_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
			//selectQuery += " AND A." + ColumnsBase.KEY_APPUSERREMARK_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

           final db = await  databaseHandler.database;

            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){

                    AppUserRemark dataItem = new AppUserRemark();
                    dataItem.appUserRemarkID = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKID];
                    dataItem.appUserRemarkCode = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKCODE];
                    dataItem.appUserRemarkDetails = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKDETAILS];
                    dataItem.appUserRemarkObject = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKOBJECT];
                    dataItem.appUserRemarkObjectID = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERREMARKOBJECTID];
                    dataItem.createdBy = element[ColumnsBase.KEY_APPUSERREMARK_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_APPUSERREMARK_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERREMARK_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERREMARK_MODIFIEDON];
                    dataItem.deviceIdentifier = element[ColumnsBase.KEY_APPUSERREMARK_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_APPUSERREMARK_REFERENCEIDENTIFIER];
                    dataItem.location = element[ColumnsBase.KEY_APPUSERREMARK_LOCATION];
                    dataItem.isActive = element[ColumnsBase.KEY_APPUSERREMARK_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_APPUSERREMARK_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERREMARK_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_APPUSERREMARK_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERREMARK_ISDELETED];
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
	    Globals.handleException( "AppUserRemarkDataHandlerBase:GetAppUserRemarkRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}