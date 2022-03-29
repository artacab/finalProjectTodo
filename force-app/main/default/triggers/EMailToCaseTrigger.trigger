trigger EMailToCaseTrigger on Case (before insert) {
    if (Trigger.isInsert && Trigger.isBefore) {
        EMailToCaseTriggerHandler.onBeforeInsert(Trigger.new);
    }
}