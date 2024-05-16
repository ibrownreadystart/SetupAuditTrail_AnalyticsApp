@isTest
public class SetupAuditTrail2Last24_BatchScheduleTest {
    @isTest static void testSchedule() {

        String cronExp = '0 0 0 15 3 ? 2090';
        String jobName = 'SetupAuditTrail2Last24_BatchScheduleTest';

        Test.startTest();
        SetupAuditTrail2Last24_BatchSchedule sched = new SetupAuditTrail2Last24_BatchSchedule();
        System.schedule(jobName, cronExp, sched);
        Test.stopTest();

        CronTrigger[] jobs = [SELECT Id, CronExpression, State FROM CronTrigger WHERE CronJobDetail.Name = :jobName];
        System.assertEquals(1, jobs.size(), 'Expected a single job to be scheduled');
        System.assertEquals(cronExp, jobs[0].CronExpression, 'Cron expression should match');
        System.assertEquals('WAITING', jobs[0].State, 'Job should be in WAITING state');
    }
}