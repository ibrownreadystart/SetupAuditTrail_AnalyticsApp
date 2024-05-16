public with sharing class SetupAuditTrail2Last24Hours_Batch implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext batchContext) {
        DateTime now = DateTime.now();
        DateTime priorTwentyFourHours = now.addHours(-24);
        String setupAuditTrailQuery = 'SELECT Id, Action, Display, CreatedBy.Name, CreatedDate FROM SetupAuditTrail ' +
                       'WHERE CreatedDate >= :priorTwentyFourHours AND CreatedDate < :now';
        if(Test.isRunningTest()) {
        	setupAuditTrailQuery += ' LIMIT 200';
    	}
        return Database.getQueryLocator(setupAuditTrailQuery);
    }

    public void execute(Database.BatchableContext batchContext, List<SetupAuditTrail> records) {
        String defaultCreatedByName = Label.SetupAuditTrail2_SfdcString;

        Map<Id, SetupAuditTrail> recordMap = new Map<Id, SetupAuditTrail>();
        for (SetupAuditTrail record : records) {
            recordMap.put(record.Id, record);
        }

        List<SetupAuditTrail2__c> existingRecords = [SELECT SetupAuditTrailRecordId__c FROM SetupAuditTrail2__c WHERE SetupAuditTrailRecordId__c IN :recordMap.keySet()];

        for (SetupAuditTrail2__c existingRecord : existingRecords) {
            recordMap.remove(existingRecord.SetupAuditTrailRecordId__c);
        }

        List<SetupAuditTrail2__c> newRecords = new List<SetupAuditTrail2__c>();
        for (SetupAuditTrail record : recordMap.values()) {
            String createdByName = String.isBlank(record.CreatedBy.Name) ? defaultCreatedByName : record.CreatedBy.Name;
            SetupAuditTrail2__c newRecord = new SetupAuditTrail2__c(
                SetupAuditTrailRecordId__c          = record.Id,
                Action__c                           = record.Action,
                Display__c                          = record.Display,
                SetupAuditTrailCreatedByName__c     = createdByName,
                SetupAuditTrailRecordCreatedDate__c = record.CreatedDate
            );
            newRecords.add(newRecord);
        }

        if (!newRecords.isEmpty()) {
            Database.SaveResult[] results = Database.insert(newRecords, false);
            logErrors(results);
        }
    }

    public void finish(Database.BatchableContext batchContext) {
        System.debug('Batch process completed. Processed ' + batchContext.getJobId());
    }

    private void logErrors(Database.SaveResult[] results) {
        List<String> errorMessages = new List<String>();
        for (Database.SaveResult result : results) {
            if (!result.isSuccess()) {
                for (Database.Error error : result.getErrors()) {
                    errorMessages.add('Error inserting record: ' + error.getMessage());
                }
            }
        }
        if (!errorMessages.isEmpty()) {
            System.debug('Errors: ' + String.join(errorMessages, '\n'));
        }
    }
}