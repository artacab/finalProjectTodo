trigger QueueTrigger on ToDo__c (before insert) {
    if (Trigger.isInsert && Trigger.isBefore) {
        QueueTriggerHandler.onBeforeInsert(Trigger.new);
    }
}