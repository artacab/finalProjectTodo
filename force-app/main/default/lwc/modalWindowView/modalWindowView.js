import { LightningElement, api } from 'lwc';

import NAME_FIELD from "@salesforce/schema/ToDo__c.Name";
import DESCRIPTION_FIELD from "@salesforce/schema/ToDo__c.Description__c";
import CATEGORY_FIELD from "@salesforce/schema/ToDo__c.Category__c";
import STATUS_FIELD from "@salesforce/schema/ToDo__c.Status__c";
import PRIORITY_FIELD from "@salesforce/schema/ToDo__c.Priority__c";
import OWNER from "@salesforce/schema/ToDo__c.OwnerId";

import SUB_NAME_FIELD from "@salesforce/schema/Sub_ToDo__c.Name";
import SUB_STATUS_FIELD from "@salesforce/schema/Sub_ToDo__c.Status__c";

export default class ModalWindowView extends LightningElement {

    @api todo;
    

    fields = [
        NAME_FIELD,
        DESCRIPTION_FIELD,
        CATEGORY_FIELD,
        PRIORITY_FIELD,
        STATUS_FIELD,
        OWNER
    ];

    fieldsSub = [
        SUB_STATUS_FIELD,
        SUB_NAME_FIELD
    ];


    closeModal(){
        this.dispatchEvent(new CustomEvent('close'));
    }
}