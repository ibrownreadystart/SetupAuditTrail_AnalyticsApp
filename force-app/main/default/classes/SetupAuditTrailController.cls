public with sharing class SetupAuditTrailController {
    @AuraEnabled
    public static void copyLast24HoursSetupAuditTrailRecords() {
        Database.executeBatch(new SetupAuditTrail2Last24Hours_Batch());
    }

    @AuraEnabled
    public static void copyLastSevenDaysSetupAuditTrailRecords() {
        Database.executeBatch(new SetupAuditTrail2LastSevenDays_Batch());
    }

    @AuraEnabled
    public static void copyAllSetupAuditTrailRecords() {
        Database.executeBatch(new SetupAuditTrail2All_Batch());
    }

    @AuraEnabled
    public static void deleteAllSetupAuditTrailRecords() {
        Database.executeBatch(new SetupAuditTrail2DeleteAll_Batch(), 2000);
    }
}