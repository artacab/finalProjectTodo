@IsTest
private class TodoBatchHelperTest {
    public static ToDo__c todo = new ToDo__c(
        Id = 'a025j000005ljVmAAI',
        Name = 'Test01',
        ExternalId__c = 'a028c00000Xbqk3AAB',
        RecordTypeId = '0125j000000MwLOAA0',
        Status__c = 'Ready to take'
    );
    
    @IsTest
    static void testPushInserted() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('TodoResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);
        List<ToDo__c> todos = new List<ToDo__c>();
        todos.add(todo);
        Test.startTest();
        TodoBatchHelper.pushInserted(todos);
        Test.stopTest();
        System.assertEquals(1, todos.size());
    }

    @IsTest
    static void testpushUpdated() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('TodoResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, new TodoHttpCalloutMock());
        List<ToDo__c> todos = new List<ToDo__c>();
        todos.add(todo);
        Test.startTest();
        TodoBatchHelper.pushUpdated(todos);
        Test.stopTest();
        System.assertEquals(1, todos.size());
    }

    @IsTest
    static void testpushDeleted() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('TodoResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, new TodoHttpCalloutMock());
        List<ToDo__c> todos = new List<ToDo__c>();
        todos.add(todo);
        Test.startTest();
        TodoBatchHelper.pushDeleted(todos);
        Test.stopTest();
        System.assertEquals(1, todos.size());
    }
}