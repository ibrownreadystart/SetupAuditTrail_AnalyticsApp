@isTest
private class SetupAuditTrailControllerTest {
    static testMethod void testCopyLast24HoursSetupAuditTrailRecords() {
        Test.startTest();
        SetupAuditTrailController.copyLast24HoursSetupAuditTrailRecords();
        Test.stopTest();
    }

    static testMethod void testCopyLastSevenDaysSetupAuditTrailRecords() {
        Test.startTest();
        SetupAuditTrailController.copyLastSevenDaysSetupAuditTrailRecords();
        Test.stopTest();
    }

    static testMethod void testCopyAllSetupAuditTrailRecords() {
        Test.startTest();
        SetupAuditTrailController.copyAllSetupAuditTrailRecords();
        Test.stopTest();
    }

    static testMethod void testDeleteAllSetupAuditTrailRecords() {
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