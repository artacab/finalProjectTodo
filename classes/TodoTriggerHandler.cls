public with sharing class TodoTriggerHandler {
    public static void onAfterInsert(List<ToDo__c> todos) {
        TodoTriggerHandlerHelper.pushInserted(todos);
    }

    public static void onAfterUpdate(List<ToDo__c> todos) {
        TodoTriggerHandlerHelper.pushUpdated(todos);
    }

    public static void onAfterDelete(List<ToDo__c> todos) {
        if (System.isFuture() || System.isBatch()){
           
        } else {
        	TodoTriggerHandlerHelper.pushDeleted(todos);
        }
    }
}