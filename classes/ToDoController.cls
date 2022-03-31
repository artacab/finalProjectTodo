public with sharing class ToDoController {

    @AuraEnabled(Cacheable=true)
    public static List<ToDo__c> getToDos(){
        return [
                SELECT Id, Name, Description__c, Creation_Date__c, Status__c, Category__c, Priority__c, OwnerId,
                    (SELECT Name, Status__c FROM Sub_ToDos__r) 
                FROM ToDo__c
                ];
    }
}