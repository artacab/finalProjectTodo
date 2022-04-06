@isTest
private class EMailToCaseTriggerHandlerHelperTest {
    @IsTest
    static void testcreateCaseTodo() {
        List<Case> cases = new List<Case>();
        Case cs = new Case();
        cs.Origin = 'Email';
        cs.Subject = 'Subject';
        cs.Description = 'Lorem ipsum dolor sit amet, ' +
        'consectetur adipiscing elit, ' +
        'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ' +
        'Ut enim ad minim veniam, ' +
        'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ' +
        'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ' +
        'Excepteur sint occaecat cupidatat non proident, ' +
        'sunt in culpa qui officia deserunt mollit anim id est laborum.';
        cs.Status = 'New';
        cases.add(cs);
        List<ToDo__c> todos = new List<ToDo__c>();

        Test.startTest();
        EMailToCaseTriggerHandler.onBeforeInsert(cases);
        todos = [SELECT Id, Name, Priority__c, Description__c FROM ToDo__c];
        Test.stopTest();

        System.assertEquals(todos.size(), 1);
        for (ToDo__c todo : todos) {
            System.assertEquals(todo.Name, 'Subject');
            System.assertEquals(todo.Priority__c, 'Low');
            System.assertEquals(todo.Description__c, 'Lorem ipsum dolor sit amet, consectetur adipisc...');
        }
    }
}