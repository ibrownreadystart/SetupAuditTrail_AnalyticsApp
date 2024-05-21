@isTest
private class SetupAuditTrailControllerTest {

    @isTest
    static void testCopyLast24HoursSetupAuditTrailRecords() {
        
        Test.startTest();
        SetupAuditTrailController.copyLast24HoursSetupAuditTrailRecords();
        Test.stopTest();

        Boolean batchJobExists = [SELECT COUNT() FROM AsyncApexJob WHERE JobType = 'BatchApex' AND Status = 'Completed' LIMIT 1] > 0;
        System.assert(batchJobExists, 'The batch job for copying the last 24 hours of records should have been enqueued.');
    }

    @isTest
    static void testCopyLastSevenDaysSetupAuditTrailRecords() {

        Test.startTest();
        SetupAuditTrailController.copyLastSevenDaysSetupAuditTrailRecords();
        Test.stopTest();

        Boolean batchJobExists = [SELECT COUNT() FROM AsyncApexJob WHERE JobType = 'BatchApex' AND Status = 'Completed' LIMIT 1] > 0;
        System.assert(batchJobExists, 'The batch job for copying the last 7 days of records should have been enqueued.');
    }

    @isTest
    static void testCopyAllSetupAuditTrailRecords() {

        Test.startTest();
        SetupAuditTrailController.copyAllSetupAuditTrailRecords();
        Test.stopTest();

        Boolean batchJobExists = [SELECT COUNT() FROM AsyncApexJob WHERE JobType = 'BatchApex' AND Status = 'Completed' LIMIT 1] > 0;
        System.assert(batchJobExists, 'The batch job for copying all records should have been enqueued.');
    }

    @isTest
    static void testDeleteAllSetupAuditTrailRecords() {

        List<SetupAuditTrail2__c> records = new List<SetupAuditTrail2__c>();

        for (Integer i = 0; i < 10; i++) {
            records.add(new SetupAuditTrail2__c(
                SetupAuditTrailRecordId__c = 'TestRecordId' + i,
                Action__c = 'Test Action',
                Display__c = 'Test Display'
            ));
        }
        insert records;

        Test.startTest();
        SetupAuditTrailController.deleteAllSetupAuditTrailRecords();
        Test.stopTest();

        List<SetupAuditTrail2__c> remainingRecords = [SELECT Id FROM SetupAuditTrail2__c];
        System.assertEquals(0, remainingRecords.size(), 'All records should have been deleted');
    }
}
