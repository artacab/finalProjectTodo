public with sharing class TodoController {
    @AuraEnabled(cacheable=true)
    public static List<Todo__c> getTodoList() {
        return [
            SELECT
                Name,
                Title__c,
                Description__c,
                Category__c,
                Priority__c,
                Status__c
            FROM Todo__c
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Todo__c> findTodos(String searchKey) {
        String key = '%' + searchKey + '%';
        return [
            SELECT
                Name,
                Title__c,
                Description__c,
                Category__c,
                Priority__c,
                Status__c
            FROM Todo__c
            WHERE Title__c LIKE :key
            WITH SECURITY_ENFORCED
            LIMIT 10
        ];
    }
}