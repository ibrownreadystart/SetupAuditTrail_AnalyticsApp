@isTest
private class SetupAuditTrail2All_BatchTest {

    @isTest
    static void testCopyAllSetupAuditTrailRecords() {

        Test.startTest();
        SetupAuditTrail2All_Batch c = new SetupAuditTrail2All_Batch();
        Database.executeBatch(c, 200); 
        Test.stopTest();

        Boolean batchJobExists = [SELECT COUNT() FROM AsyncApexJob WHERE JobType = 'BatchApex' AND Status = 'Completed' LIMIT 1] > 0;
        System.assert(batchJobExists, 'The batch job for copying all SetupAuditTrail records should have been enqueued.');
    }   
}

