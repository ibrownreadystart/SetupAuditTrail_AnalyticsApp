public with sharing class SetupAuditTrail2Last24_BatchSchedule implements Schedulable {

    public static void execute(SchedulableContext sc) {
        
        SetupAuditTrail2Last24Hours_Batch batch = new SetupAuditTrail2Last24Hours_Batch();
        Database.executeBatch(batch);
    }
}