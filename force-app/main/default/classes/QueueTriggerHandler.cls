public with sharing class QueueTriggerHandler {
    public static void onBeforeInsert(List<ToDo__c> todos) {
        QueueTriggerHandlerHelper.assignmentQueue(todos);
    }
}