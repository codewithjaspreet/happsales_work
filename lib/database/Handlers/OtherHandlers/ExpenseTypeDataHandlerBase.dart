import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/ExpenseType.dart';
import '../DataBaseHandler.dart';

class ExpenseTypeDataHandlerBase {
  static Future<List<ExpenseType>> GetExpenseTypeRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<ExpenseType> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery = "SELECT A.* ";
      selectQuery += "${" FROM " + TablesBase.TABLE_EXPENSETYPE} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = " +
          Globals.AppUserID.toString();
      selectQuery += " AND A.${ColumnsBase.KEY_EXPENSETYPE_APPUSERGROUPID} = " +
          Globals.AppUserGroupID.toString();
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_EXPENSETYPE_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_EXPENSETYPE_ISACTIVE},'true')) = 'true' ";
      //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ExpenseType_ISARCHIVED + ",'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPENAME} LIKE '%${searchString.replaceAll("'", "''")}%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_ExpenseType_Columns.KEY_EXPENSETYPE_EXPENSETYPENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery +=
          "${" LIMIT " + startRowIndex.toString()}," + pageSize.toString();

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ExpenseType dataItem = new ExpenseType();
        dataItem.expenseTypeID =
            element[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPEID];
        dataItem.expenseTypeCode =
            element[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPECODE];
        dataItem.expenseTypeName =
            element[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPENAME];
        dataItem.isTravelRequired =
            element[ColumnsBase.KEY_EXPENSETYPE_ISTRAVELREQUIRED];
        dataItem.calculateDistanceTravelled =
            element[ColumnsBase.KEY_EXPENSETYPE_CALCULATEDISTANCETRAVELLED];
        dataItem.createdOn = element[ColumnsBase.KEY_EXPENSETYPE_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_EXPENSETYPE_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_EXPENSETYPE_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_EXPENSETYPE_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_EXPENSETYPE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_EXPENSETYPE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_EXPENSETYPE_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_EXPENSETYPE_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_EXPENSETYPE_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_EXPENSETYPE_ISDELETED];

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
          "ExpenseTypeDataHandlerBase:GetExpenseTypeRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<ExpenseType>> GetExpenseTypeRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<ExpenseType> dataList = [];
    try {
      String selectQuery = "SELECT A.* ";
      selectQuery += "${" FROM " + TablesBase.TABLE_EXPENSETYPE} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = " +
          Globals.AppUserID.toString();
      selectQuery += " AND A.${ColumnsBase.KEY_EXPENSETYPE_APPUSERGROUPID} = " +
          Globals.AppUserGroupID.toString();
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_EXPENSETYPE_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_EXPENSETYPE_ISACTIVE},'true')) = 'true' ";
      //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ExpenseType_ISARCHIVED + ",'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery +=
            "${" AND A." + ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPENAME + " LIKE '" + searchString.replaceAll("'", "''")}%'";
      }
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPENAME} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ExpenseType dataItem = new ExpenseType();
        dataItem.expenseTypeID =
            element[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPEID];
        dataItem.expenseTypeCode =
            element[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPECODE];
        dataItem.expenseTypeName =
            element[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPENAME];
        dataItem.isTravelRequired =
            element[ColumnsBase.KEY_EXPENSETYPE_ISTRAVELREQUIRED];
        dataItem.calculateDistanceTravelled =
            element[ColumnsBase.KEY_EXPENSETYPE_CALCULATEDISTANCETRAVELLED];
        dataItem.createdOn = element[ColumnsBase.KEY_EXPENSETYPE_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_EXPENSETYPE_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_EXPENSETYPE_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_EXPENSETYPE_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_EXPENSETYPE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_EXPENSETYPE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_EXPENSETYPE_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_EXPENSETYPE_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_EXPENSETYPE_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_EXPENSETYPE_ISDELETED];

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
          "ExpenseTypeDataHandlerBase:GetExpenseTypeRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<ExpenseType?> GetExpenseTypeRecord(
      DatabaseHandler databaseHandler, String id) async {
    ExpenseType? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* ";
      selectQuery += "${" FROM " + TablesBase.TABLE_EXPENSETYPE} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = " +
          Globals.AppUserID.toString();
      selectQuery += " AND A.${ColumnsBase.KEY_EXPENSETYPE_APPUSERGROUPID} = " +
          Globals.AppUserGroupID.toString();

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        dataItem = new ExpenseType();
        dataItem.expenseTypeID =
            element[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPEID];
        dataItem.expenseTypeCode =
            element[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPECODE];
        dataItem.expenseTypeName =
            element[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPENAME];
        dataItem.isTravelRequired =
            element[ColumnsBase.KEY_EXPENSETYPE_ISTRAVELREQUIRED];
        dataItem.calculateDistanceTravelled =
            element[ColumnsBase.KEY_EXPENSETYPE_CALCULATEDISTANCETRAVELLED];
        dataItem.createdOn = element[ColumnsBase.KEY_EXPENSETYPE_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_EXPENSETYPE_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_EXPENSETYPE_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_EXPENSETYPE_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_EXPENSETYPE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_EXPENSETYPE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_EXPENSETYPE_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_EXPENSETYPE_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_EXPENSETYPE_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_EXPENSETYPE_ISDELETED];

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
          "ExpenseTypeDataHandlerBase:GetExpenseTypeRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<ExpenseType?> GetExpenseTypeRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    ExpenseType? dataItem;
    try {
      String selectQuery = "SELECT A.* ";
      selectQuery += "${" FROM " + TablesBase.TABLE_EXPENSETYPE} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_EXPENSETYPE_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
      //selectQuery += " AND A." + ColumnsBase.KEY_EXPENSETYPE_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        dataItem = new ExpenseType();
        dataItem.expenseTypeID =
            element[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPEID];
        dataItem.expenseTypeCode =
            element[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPECODE];
        dataItem.expenseTypeName =
            element[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPENAME];
        dataItem.isTravelRequired =
            element[ColumnsBase.KEY_EXPENSETYPE_ISTRAVELREQUIRED];
        dataItem.calculateDistanceTravelled =
            element[ColumnsBase.KEY_EXPENSETYPE_CALCULATEDISTANCETRAVELLED];
        dataItem.createdOn = element[ColumnsBase.KEY_EXPENSETYPE_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_EXPENSETYPE_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_EXPENSETYPE_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_EXPENSETYPE_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_EXPENSETYPE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_EXPENSETYPE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_EXPENSETYPE_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_EXPENSETYPE_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_EXPENSETYPE_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_EXPENSETYPE_ISDELETED];

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
          "ExpenseTypeDataHandlerBase:GetExpenseTypeRecordByUid()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<ExpenseType?> GetMasterExpenseTypeRecord(
      DatabaseHandler databaseHandler, String id) async {
    ExpenseType? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* ";
      selectQuery += "${" FROM " + TablesBase.TABLE_EXPENSETYPE} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPEID} = $id";
      selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = " +
          Globals.AppUserID.toString();
      selectQuery += " AND A.${ColumnsBase.KEY_EXPENSETYPE_APPUSERGROUPID} = " +
          Globals.AppUserGroupID.toString();

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        dataItem = new ExpenseType();
        dataItem.expenseTypeID =
            element[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPEID];
        dataItem.expenseTypeCode =
            element[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPECODE];
        dataItem.expenseTypeName =
            element[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPENAME];
        dataItem.isTravelRequired =
            element[ColumnsBase.KEY_EXPENSETYPE_ISTRAVELREQUIRED];
        dataItem.calculateDistanceTravelled =
            element[ColumnsBase.KEY_EXPENSETYPE_CALCULATEDISTANCETRAVELLED];
        dataItem.createdOn = element[ColumnsBase.KEY_EXPENSETYPE_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_EXPENSETYPE_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_EXPENSETYPE_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_EXPENSETYPE_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_EXPENSETYPE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_EXPENSETYPE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_EXPENSETYPE_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_EXPENSETYPE_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_EXPENSETYPE_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_EXPENSETYPE_ISDELETED];

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
          "ExpenseTypeDataHandlerBase:GetMasterExpenseTypeRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddExpenseTypeRecord(
      DatabaseHandler databaseHandler, ExpenseType dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};
      if (dataItem.expenseTypeID != null && dataItem.expenseTypeID != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPEID] =
            dataItem.expenseTypeID;
      }
      if (dataItem.expenseTypeCode != null &&
          dataItem.expenseTypeCode != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPECODE] =
            dataItem.expenseTypeCode;
      }
      if (dataItem.expenseTypeName != null &&
          dataItem.expenseTypeName != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPENAME] =
            dataItem.expenseTypeName;
      }
      if (dataItem.isTravelRequired != null &&
          dataItem.isTravelRequired != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_ISTRAVELREQUIRED] =
            dataItem.isTravelRequired;
      }
      if (dataItem.calculateDistanceTravelled != null &&
          dataItem.calculateDistanceTravelled != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_CALCULATEDISTANCETRAVELLED] =
            dataItem.calculateDistanceTravelled;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_CREATEDON] = dataItem.createdOn;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_CREATEDBY] = dataItem.createdBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_MODIFIEDON] = dataItem.modifiedOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_MODIFIEDBY] = dataItem.modifiedBy;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_ISACTIVE] = dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_APPUSERID] = dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_ISARCHIVED] = dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_ISDELETED] = dataItem.isDeleted;
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

      id = await db.insert(TablesBase.TABLE_EXPENSETYPE, values);
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:AddExpenseTypeRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateExpenseTypeRecord(
      DatabaseHandler databaseHandler, String id1, ExpenseType dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};
      if (dataItem.expenseTypeID != null && dataItem.expenseTypeID != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPEID] =
            dataItem.expenseTypeID;
      }
      if (dataItem.expenseTypeCode != null &&
          dataItem.expenseTypeCode != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPECODE] =
            dataItem.expenseTypeCode;
      }
      if (dataItem.expenseTypeName != null &&
          dataItem.expenseTypeName != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPENAME] =
            dataItem.expenseTypeName;
      }
      if (dataItem.isTravelRequired != null &&
          dataItem.isTravelRequired != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_ISTRAVELREQUIRED] =
            dataItem.isTravelRequired;
      }
      if (dataItem.calculateDistanceTravelled != null &&
          dataItem.calculateDistanceTravelled != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_CALCULATEDISTANCETRAVELLED] =
            dataItem.calculateDistanceTravelled;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_CREATEDON] = dataItem.createdOn;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_CREATEDBY] = dataItem.createdBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_MODIFIEDON] = dataItem.modifiedOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_MODIFIEDBY] = dataItem.modifiedBy;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_ISACTIVE] = dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_APPUSERID] = dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_ISARCHIVED] = dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_EXPENSETYPE_ISDELETED] = dataItem.isDeleted;
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

      if (dataItem.upSyncIndex != null && dataItem.upSyncIndex != "null") {
        values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;
      }

      id = await db.update(TablesBase.TABLE_EXPENSETYPE, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:UpdateExpenseTypeRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteExpenseTypeRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_EXPENSETYPE,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:DeleteExpenseTypeRecord()", ex);
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
          "SELECT A.${ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPEID}";
      selectQuery += "${" FROM " + TablesBase.TABLE_EXPENSETYPE} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        serverId = result[0][ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPEID];
      }
    } catch (ex) {
      Globals.handleException("ExpenseTypeDataHandlerBase:GetServerId()", ex);
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
      selectQuery += "${" FROM " + TablesBase.TABLE_EXPENSETYPE} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPEID} = $id";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        localId = result[0][ColumnsBase.KEY_ID];
      }
    } catch (ex) {
      Globals.handleException("ExpenseTypeDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<ExpenseType>> GetExpenseTypeUpSyncRecords(
      DatabaseHandler databaseHandler, String changeType) async {
    List<ExpenseType> dataList = [];
    try {
      String selectQuery =
          "${"SELECT * FROM " + TablesBase.TABLE_EXPENSETYPE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
              Globals.SyncIndex.toString();
      /*if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_EXPENSETYPE + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_EXPENSETYPE + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }*/
      selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = " +
          Globals.AppUserID.toString();
      selectQuery += " AND ${ColumnsBase.KEY_EXPENSETYPE_APPUSERGROUPID} = " +
          Globals.AppUserGroupID.toString();

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ExpenseType dataItem = new ExpenseType();
        dataItem.expenseTypeID =
            element[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPEID];
        dataItem.expenseTypeCode =
            element[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPECODE];
        dataItem.expenseTypeName =
            element[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPENAME];
        dataItem.isTravelRequired =
            element[ColumnsBase.KEY_EXPENSETYPE_ISTRAVELREQUIRED];
        dataItem.calculateDistanceTravelled =
            element[ColumnsBase.KEY_EXPENSETYPE_CALCULATEDISTANCETRAVELLED];
        dataItem.createdOn = element[ColumnsBase.KEY_EXPENSETYPE_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_EXPENSETYPE_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_EXPENSETYPE_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_EXPENSETYPE_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_EXPENSETYPE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_EXPENSETYPE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_EXPENSETYPE_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_EXPENSETYPE_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_EXPENSETYPE_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_EXPENSETYPE_ISDELETED];

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
          "ExpenseTypeDataHandlerBase:GetExpenseTypeUpSyncRecords()", ex);
      throw ex;
    }
    return dataList;
  }
}
