@isTest
private class SetupAuditTrail2LastSevenDays_BatchTest {

    @isTest
    static void testCopyLast7DaysSetupAuditTrailRecords() {

        Test.startTest();
        SetupAuditTrail2LastSevenDays_Batch c = new SetupAuditTrail2LastSevenDays_Batch();
        Database.executeBatch(c, 200);
        Test.stopTest();

        Boolean batchJobExists = [SELECT COUNT() FROM AsyncApexJob WHERE JobType = 'BatchApex' AND Status = 'Completed' LIMIT 1] > 0;
        System.assert(batchJobExists, 'The batch job for copying the last seven days of records should have been enqueued.');
    }
}
