import { LightningElement, wire, track } from 'lwc';
import getTodoList from '@salesforce/apex/TodoController.getTodoList';
import findTodos from '@salesforce/apex/TodoController.findTodos';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { reduceErrors } from 'c/ldsUtils';
import { refreshApex } from '@salesforce/apex';
import { deleteRecord } from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Todo__c.Name';
import DESCRIPTION_FIELD from '@salesforce/schema/Todo__c.Description__c';
import CATEGORY_FIELD from '@salesforce/schema/Todo__c.Category__c';
import PRIORITY_FIELD from '@salesforce/schema/Todo__c.Priority__c';
import TITLE_FIELD from '@salesforce/schema/Todo__c.Title__c';
import STATUS_FIELD from '@salesforce/schema/Todo__c.Status__c';

const DELAY = 300;

export default class todoList extends LightningElement {
    searchKey = '';

    @wire(getTodoList) todos;
    @track isModalOpen = false;
    @track isCreateMode = false;
    @track isEditMode = false;
    todoIdEdit;
    todoId;
    fields = [NAME_FIELD, TITLE_FIELD, DESCRIPTION_FIELD, CATEGORY_FIELD, PRIORITY_FIELD,STATUS_FIELD];
    
    @wire(findTodos, { searchKey: '$searchKey' })
    todos;

    handleKeyChange(event) {
        console.log(this.todos);
        window.clearTimeout(this.delayTimeout);
        const searchKey = event.target.value;
        this.delayTimeout = setTimeout(() => {
            this.searchKey = searchKey;
        }, DELAY);
    }

    openModal() {
        this.isModalOpen = true;
    }

    closeModal() {
        this.isModalOpen = false;
        this.isCreateMode = false;
        this.isEditMode = false; 
    }

    editTodo(event) {
        this.todoIdEdit = event.detail;
        this.isEditMode = true;
        this.openModal();
    }

    successEditTodo() {
        this.closeModal();
        return refreshApex(this.todos);
    }

    successCreateTodo() {
        this.closeModal();
        return refreshApex(this.todos);
    }

    createTodoMode() {
        this.isCreateMode = true;
        this.openModal();
    }
    
    deleteTodo(event) {
      const recordId = event.detail;
      deleteRecord(recordId)
          .then(() => {
              this.dispatchEvent(
                  new ShowToastEvent({
                      title: 'Success',
                      message: 'Todo deleted',
                      variant: 'success'
                  })
              );
              return refreshApex(this.todos);
          })
          .catch((error) => {
              this.dispatchEvent(
                  new ShowToastEvent({
                      title: 'Error deleting record',
                      message: reduceErrors(error).join(', '),
                      variant: 'error'
                  })
              );
          });
  }
}