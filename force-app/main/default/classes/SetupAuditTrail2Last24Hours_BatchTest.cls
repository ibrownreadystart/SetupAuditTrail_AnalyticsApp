@isTest
private class SetupAuditTrail2Last24Hours_BatchTest {

    @isTest
    static void testCopyLast24HoursSetUpAuditTrailRecords() {

        Test.startTest();
        SetupAuditTrail2Last24Hours_Batch c = new SetupAuditTrail2Last24Hours_Batch();
        Database.executeBatch(c, 200);
        Test.stopTest();

        Boolean batchJobExists = [SELECT COUNT() FROM AsyncApexJob WHERE JobType = 'BatchApex' AND Status = 'Completed' LIMIT 1] > 0;
        System.assert(batchJobExists, 'The batch job for copying the last 24 hours of records should have been enqueued.');
    }
}
