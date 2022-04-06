trigger SubTrigger on Sub_ToDo__c (after insert, after update, after delete) {
    if (Trigger.isInsert && Trigger.isAfter) {
        SubTriggerHandler.onAfterInsert(Trigger.new);
    } else if (Trigger.isUpdate && Trigger.isAfter) {
        SubTriggerHandler.onAfterUpdate(Trigger.new);
    } else if (Trigger.isDelete && Trigger.isAfter) {
        SubTriggerHandler.onAfterDelete(Trigger.old);
    }
}