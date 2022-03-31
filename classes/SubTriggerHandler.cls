public with sharing class SubTriggerHandler {
    public static void onAfterInsert(List<Sub_ToDo__c> subs) {
        SubTriggerHandlerHelper.pushInserted(subs);
    }

    public static void onAfterUpdate(List<Sub_ToDo__c> subs) {
        SubTriggerHandlerHelper.pushUpdated(subs);
    }

    public static void onAfterDelete(List<Sub_ToDo__c> subs) {
        SubTriggerHandlerHelper.pushDeleted(subs);
    }
}