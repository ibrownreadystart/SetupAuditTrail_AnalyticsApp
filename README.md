### SetupAuditTrail Analytics:

No Event Monitoring and no interest in SOQL, browser extensions, or taking data out of Salesforce? 

Mirror the SetupAuditTrail setup object and leverage native Salesforce Reports and Dashboards.

![Screenshot of a comment on a GitHub issue showing an image, added in the Markdown, of an Octocat smiling and raising a tentacle.](https://github.com/ibrownreadystart/SetupAuditTrail_AnalyticsApp/blob/main/images/setupaudittrailanalyticsscreen.png)

### Install SetupAuditTrail Analytics:

The below installation links are also available to install as an unlocked package:

Install in [Sandbox](https://test.salesforce.com/packaging/installPackage.apexp?p0=04tU1000000LFNRIA4).

Install in [Production](https://login.salesforce.com/packaging/installPackage.apexp?p0=04tU1000000LFNRIA4).

### What is SetupAuditTrail Analytics?

A free, unlocked package which can be installed in production or test instances (sandbox, scratch orgs, developer edition orgs, or trailhead playgrounds) and provisioned to Admin users. It facilitates on-demand (or scheduled) copying of SetupAuditTrail record entries. Supplied intervals are: Copy Last 24 Hours, Copy Last 7 Days, and Copy All. 

Click the interval you are interested in and refresh the report chart component to see the results. 

Scheduled apex is included and can be used to schedule runs that will retrieve all records from the last 24 Hours. The scheduled apex can run independently or used with the on-demand refresh without duplicating data in the destination object.

### Does SetupAuditTrail Analytics use Data Storage?

Yes! 

SetupAuditTrail does not allow aggregate queries, native reporting, or record-triggered automation. As a setup object, it is unlikely that these features will ever be available on this object. To workaround this for tactical research and use cases, SetupAuditTrail Analytics copies the record data from the standard SetupAuditTrail object into a custom object, SetupAuditTrail2__c. Depending on your data storage, residency, archival, and compliance environment, use this app as needed and accordingly.

SetupAuditTrail Analytics includes a Delete All feature to remove all the data in the custom object when needed. Object records can also be deleted using alternate scheduled automation at an interval appropriate for your use case. Once you are finished using SetupAuditTrail Analytics or you adopt an alternate solution, simply delete the app and data from your org.

### NOTE: 

This solution uses batch apex. 
