import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import copyLast24HoursSetupAuditTrailRecords from '@salesforce/apex/SetupAuditTrailController.copyLast24HoursSetupAuditTrailRecords';
import copyLastSevenDaysSetupAuditTrailRecords from '@salesforce/apex/SetupAuditTrailController.copyLastSevenDaysSetupAuditTrailRecords';
import copyAllSetupAuditTrailRecords from '@salesforce/apex/SetupAuditTrailController.copyAllSetupAuditTrailRecords';
import deleteAllSetupAuditTrailRecords from '@salesforce/apex/SetupAuditTrailController.deleteAllSetupAuditTrailRecords';

export default class CopySetupAuditTrail extends LightningElement {
    handlePromise(promise, successMessage) {
        promise
            .then(() => {
                this.showToast('Success', successMessage, 'success');
            })
            .catch((error) => {
                this.showToast('Error', this.getErrorMessage(error), 'error');
            });
    }

    copyLast24HoursRecords() {
        this.handlePromise(copyLast24HoursSetupAuditTrailRecords(), "Last 24 hours' records copying initiated.");
    }

    copyLastSevenDaysRecords() {
        this.handlePromise(copyLastSevenDaysSetupAuditTrailRecords(), "Last 7 days' records copying initiated.");
    }

    copyAllRecords() {
        this.handlePromise(copyAllSetupAuditTrailRecords(), "All records copying initiated.");
    }

    deleteAllRecords() {
        this.handlePromise(deleteAllSetupAuditTrailRecords(), "All audit trail records have been deleted.");
    }

    showToast(title, message, variant) {
        const evt = new ShowToastEvent({
            title,
            message,
            variant,
        });
        this.dispatchEvent(evt);
    }

    getErrorMessage(error) {
        if (error.body && error.body.message) {
            return error.body.message;
        }
        if (error.message) {
            return error.message;
        }
        if (error.stack) {
            return error.stack;
        }
        return 'Unknown error'; // Fallback message
    }
}