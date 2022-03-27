import { LightningElement, api} from 'lwc';
import { createRecord, deleteRecord  } from 'lightning/uiRecordApi';

import NAME_FIELD from "@salesforce/schema/ToDo__c.Name";
import DESCRIPTION_FIELD from "@salesforce/schema/ToDo__c.Description__c";
import CATEGORY_FIELD from "@salesforce/schema/ToDo__c.Category__c";
import STATUS_FIELD from "@salesforce/schema/ToDo__c.Status__c";
import PRIORITY_FIELD from "@salesforce/schema/ToDo__c.Priority__c";
import OWNER_FIELD from "@salesforce/schema/ToDo__c.OwnerId";


import SUB_NAME_FIELD from "@salesforce/schema/Sub_ToDo__c.Name";
import SUB_STATUS_FIELD from "@salesforce/schema/Sub_ToDo__c.Status__c";

export default class ModalWindowEdit extends LightningElement {

    @api todo;


    fields = [
        NAME_FIELD,
        DESCRIPTION_FIELD,
        CATEGORY_FIELD,
        PRIORITY_FIELD,
        STATUS_FIELD,
        OWNER_FIELD
    ];

    fieldsSub = [
        SUB_STATUS_FIELD,
        SUB_NAME_FIELD
    ];

    isAdding = false;


    closeModal() {
        this.dispatchEvent(new CustomEvent('close'));
    }

    assignToMe(){
        this.dispatchEvent(new CustomEvent('assigntome', {detail: this.todo.Id}));
    }

    assignToToday(){
        this.dispatchEvent(new CustomEvent('assigntotoday', {detail: this.todo.Id}));
    }

    assignToTomorrow(){
        this.dispatchEvent(new CustomEvent('assigntotomorrow', {detail: this.todo.Id}));
    }

    assignToLater(){
        this.dispatchEvent(new CustomEvent('assigntolater', {detail: this.todo.Id}));
    }

    handleDelete(){
        this.closeModal();
        this.dispatchEvent(new CustomEvent('delete', {detail: this.todo.Id}));
    }

    deleteSubTodo(event){
        this.dispatchEvent(new CustomEvent('update', {detail: this.todo}));
        deleteRecord(event.target.dataset.item);
    }

    handleAddSubTodo(){
        this.isAdding = true;
    }

    async createSubToDo(event){
        event.preventDefault();
        let fields = {
                        'Status__c': event.detail.fields.Status__c,
                        'Name': event.detail.fields.Name,
                        'ToDo__c': this.todo.Id
                    };

        let objRecordInput = {'apiName': 'Sub_ToDo__c',  fields};

        await createRecord(objRecordInput);
                
        this.dispatchEvent(new CustomEvent('update', {detail: this.todo}));

        this.isAdding = false;
    }
}