@isTest
private class SetupAuditTrail2DeleteAll_BatchTest {
    static testMethod void test() {
        List<SetupAuditTrail2__c> records = new List<SetupAuditTrail2__c>();
        for (Integer i = 0; i < 10; i++) {
            records.add(new SetupAuditTrail2__c(
                SetupAuditTrailRecordId__c = 'TestRecordId' + i,
                Action__c = 'SetupAction',
                Display__c = 'SetupActionInstanceDescription'
            ));
        }
        insert records;

        Test.startTest();
        SetupAuditTrail2DeleteAll_Batch c = new SetupAuditTrail2DeleteAll_Batch();
        Database.executeBatch(c, 200);
        Test.stopTest();

        List<SetupAuditTrail2__c> remainingRecords = [SELECT Id FROM SetupAuditTrail2__c];
        System.assertEquals(0, remainingRecords.size(), 'All records should have been deleted');
    }
}