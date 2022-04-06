@isTest
private class ToDoControllerTest {
    @TestSetup
    static void setup() {
        ToDo__c todo = new ToDo__c(
                Name = 'Test01',
                Description__c = 'Description',
                Category__c = 'Today',
                Status__c = 'Ready to take'
        );

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('TodoResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, new TodoHttpCalloutMock());

        insert todo;
    }

    @IsTest
    static void testgetToDos() {
        ToDo__c todo = [SELECT Id FROM ToDo__c WHERE Name = 'Test01'];

        Test.startTest();
        List<ToDo__c> todos = ToDoController.getToDos();
        Test.stopTest();

        System.assert(todos != null);
        for (ToDo__c result: todos){
            System.assertEquals(toDo.Id, result.Id);

        }
    }
    @IsTest
    static void testgetTodayId() {
        Test.startTest();
        Id todoId = ToDoController.getTodayId();
        Test.stopTest();
        System.assert(todoId != null);
     	System.assertEquals(todoId, '00G5j0000010so8EAA');
    }
    @IsTest
    static void testgetTomorrowId() {
        Test.startTest();
        Id todoId = ToDoController.getTomorrowId();
        Test.stopTest();
        System.assert(todoId != null);
     	System.assertEquals(todoId, '00G5j0000010so9EAA');
    }
    @IsTest
    static void testgetLaterId() {
        Test.startTest();
        Id todoId = ToDoController.getLaterId();
        Test.stopTest();
        System.assert(todoId != null);
     	System.assertEquals(todoId, '00G5j0000010so7EAA');
    }
}