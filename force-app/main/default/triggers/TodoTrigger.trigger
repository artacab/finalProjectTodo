trigger TodoTrigger on ToDo__c (after insert, after update, after delete) {
    if (Trigger.isInsert && Trigger.isAfter) {
        TodoTriggerHandler.onAfterInsert(Trigger.new);
    } else if (Trigger.isUpdate && Trigger.isAfter) {
        TodoTriggerHandler.onAfterUpdate(Trigger.new);
    } else if (Trigger.isDelete && Trigger.isAfter) {
        TodoTriggerHandler.onAfterDelete(Trigger.old);
    }
}