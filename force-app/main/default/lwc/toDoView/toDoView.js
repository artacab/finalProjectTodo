import { LightningElement, api } from 'lwc';

export default class ToDoColumn extends LightningElement {

    @api name;
    @api todos;

    handleEdit(event){
        this.dispatchEvent(new CustomEvent('edit', {detail: event.detail}));
    }

    handleView(event){
        console.log(this.todos);
        this.dispatchEvent(new CustomEvent('view', {detail: event.detail}));
    }
}