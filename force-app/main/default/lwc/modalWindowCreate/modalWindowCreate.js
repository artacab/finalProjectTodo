import { LightningElement, wire, track } from 'lwc';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';

import NAME_FIELD from "@salesforce/schema/ToDo__c.Name";
import DESCRIPTION_FIELD from "@salesforce/schema/ToDo__c.Description__c";
import CATEGORY_FIELD from "@salesforce/schema/ToDo__c.Category__c";
import STATUS_FIELD from "@salesforce/schema/ToDo__c.Status__c";
import PRIORITY_FIELD from "@salesforce/schema/ToDo__c.Priority__c";
import TODO_OBJECT from "@salesforce/schema/ToDo__c";


export default class ModalWindowCreate extends LightningElement {

    @wire(getObjectInfo, { objectApiName: TODO_OBJECT })
    objectInfo;
    @track objectInfo;
    @track recordTypeIdVal;

    @track isRTModalOpen = true;

    fields = [
        NAME_FIELD,
        DESCRIPTION_FIELD,
        CATEGORY_FIELD,
        PRIORITY_FIELD,
        STATUS_FIELD
    ];

    closeModal() {
        this.dispatchEvent(new CustomEvent('close'));
    }

    handleSubmit(event) {
        event.preventDefault();
        const fields = event.detail.fields;
        this.template.querySelector('lightning-record-form').submit(fields);
    }

    get recordTypeId() {

        var recordtypeinfo = this.objectInfo.data.recordTypeInfos;
        var uiCombobox = [];

        for (var eachRecordtype in recordtypeinfo) {
            if (recordtypeinfo.hasOwnProperty(eachRecordtype) && !recordtypeinfo[eachRecordtype].master)
                uiCombobox.push({ label: recordtypeinfo[eachRecordtype].name, value: recordtypeinfo[eachRecordtype].name })
        }

        return uiCombobox;
    }

    handleChange(event) {
        const rtis = this.objectInfo.data.recordTypeInfos;
        console.log(rtis)
        this.recordTypeIdVal = (Object.keys(rtis).find(rti => rtis[rti].name === this.optionVal));
        console.log(this.recordTypeIdVal)
        if(!this.recordTypeIdVal){
            this.closeRTModal();
        }
        this.isRTModalOpen = false;
    }

    changeHandler(event){
        this.optionVal = event.target.value;
    }

    closeRTModal(){
        this.isRTModalOpen = false;
        this.closeModal();
    }
}