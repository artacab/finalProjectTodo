@isTest
private class EMailToCaseTriggerHandlerHelperTest {
    @IsTest
    static void testcreateCaseTodo() {
        List<Case> cases = new List<Case>();
        Case cs = new Case();
        cs.Origin = 'Email';
        cs.Subject = 'Subject';
        cs.Description = 'Hello!';
        cs.Status = 'New';
        cases.add(cs);
        List<ToDo__c> todos = new List<ToDo__c>();

        Test.startTest();
        EMailToCaseTriggerHandler.onBeforeInsert(cases);
        todos = [SELECT Id, Name, Priority__c, Description__c FROM ToDo__c];
        //todos = [SELECT Id, Name, Priority__c FROM ToDo__c];
        Test.stopTest();

        System.assertEquals(todos.size(), 1);
        for (ToDo__c todo : todos) {
            System.assertEquals(todo.Name, 'Subject');
            System.assertEquals(todo.Priority__c, 'Low');
            System.assertEquals(todo.Description__c, 'Hello!');
        }
    }
}