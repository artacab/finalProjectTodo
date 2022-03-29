public with sharing class EMailToCaseTriggerHandlerHelper {
    public static void createCaseTodo(List<Case> cases) {
        List<ToDo__c> todos = new List<ToDo__c>();

        for (Case cs : cases) {
            if (cs.Origin == 'Email') {
                ToDo__c todo = new ToDo__c(
                    Name = cs.Subject,
                    Priority__c = 'Low',
                    Description__c = (cs.Description).abbreviate(50)
                );
                todos.add(todo);
                System.debug(todo);
            }
        }
        
        insert todos;
    }
}