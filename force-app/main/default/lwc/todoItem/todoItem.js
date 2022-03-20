import { LightningElement, api } from "lwc";

export default class todoItem extends LightningElement {
  @api todo;

  get colorClass(){
    return `${this.todo.Category__c.toLowerCase()}`
  }

  handleClickDelete(event) {
    event.preventDefault();
    const selectEvent = new CustomEvent('selectdel', {
        detail: this.todo.Id
    });
    this.dispatchEvent(selectEvent);
  }
  handleClickEdit(event) {
    event.preventDefault();
    const selectEvent = new CustomEvent('selectedit', {
        detail: this.todo.Id
    });
    this.dispatchEvent(selectEvent);
  }
}