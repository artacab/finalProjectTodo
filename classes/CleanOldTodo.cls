public with sharing class CleanOldTodo implements Database.Batchable<ToDo__c>, Database.AllowsCallouts {
    public List<ToDo__c> start(Database.BatchableContext param1) {      
        Integer daysAgo = Integer.valueOf([SELECT Days__c FROM CleanToDoList__mdt][0].Days__c);
        
        return [SELECT Id, 
                Name,
                Description__c,
                Creation_Date__c,
                Category__c,
                Priority__c,
                Status__c,
                ExternalId__c,
                RecordTypeId,
                CreatedDate FROM ToDo__c WHERE CreatedDate < :Date.today().addDays(-daysAgo)];
    }
    public void execute(Database.BatchableContext param1, List<ToDo__c> oldTodos) {
        TodoBatchHelper.pushDeleted(oldTodos);
        delete oldTodos;
    }

    public void finish(Database.BatchableContext param1) {
    }
}