public with sharing class SetupAuditTrail2DeleteAll_Batch implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext batchContext) {
        return Database.getQueryLocator([SELECT Id FROM SetupAuditTrail2__c]);
    }

    public void execute(Database.BatchableContext batchContext, List<SetupAuditTrail2__c> scope) {
        try {
            Database.delete(scope, false);
        } catch (Exception e) {
            System.debug('An error occurred while deleting records: ' + e.getMessage());
        }
    }

    public void finish(Database.BatchableContext batchContext) {
        System.debug('Batch delete process completed.');
    }
}