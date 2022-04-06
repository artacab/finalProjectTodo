@IsTest
private class ResponseWrapperTest {
    public static ToDo__c todo = new ToDo__c(
        Id = 'a0009000007RU4WAAW',
        Name = 'Test01',
        ExternalId__c = 'a010900000nVG0NAAW',
        RecordTypeId = '012090000006M9QAAU',
        Status__c = 'Ready to take'
    );

    @IsTest
    static void testDoMapping() {
        ResponseWrapper wrapper = new ResponseWrapper();
        wrapper.id = todo.Id;
        wrapper.name = todo.Name;
        wrapper.description = todo.Description__c;
        wrapper.creationDate = todo.Creation_Date__c;
        wrapper.category = todo.Category__c;
        wrapper.priority = todo.Priority__c;
        wrapper.status = todo.Status__c;
        wrapper.externalId = todo.ExternalId__c;
        wrapper.rectypeName = [SELECT Name FROM RecordType WHERE Id =: todo.RecordTypeId].Name;
        System.debug('wrapper: ' + wrapper);

        Test.startTest();
        ResponseWrapper newWrapper = ResponseWrapper.doMapping(todo);
        Test.stopTest();
        System.debug('newWrapper: ' + newWrapper);

        System.assertEquals(wrapper.id, newWrapper.id);
        System.assertEquals(wrapper.name, newWrapper.name);
        System.assertEquals(wrapper.status, newWrapper.status);
    }

    @IsTest
    static void testdoMappingToWrappers() {
        ResponseWrapper wrapper = new ResponseWrapper();
        wrapper.id = todo.Id;
        wrapper.name = todo.Name;
        wrapper.status = todo.Status__c;
        wrapper.externalId = todo.ExternalId__c;

        List<ToDo__c> todos = new List<ToDo__c>();
        todos.add(todo);
        System.debug('todos: ' + todos);

        Test.startTest();
        List<ResponseWrapper> wrappers = ResponseWrapper.doMappingToWrappers(todos);
        Test.stopTest();
        System.debug('wrappers: ' + wrappers);

        for (ResponseWrapper newWrapper : wrappers) {
            System.assertEquals(wrapper.id, newWrapper.id);
            System.assertEquals(wrapper.name, newWrapper.name);
            System.assertEquals(wrapper.status, newWrapper.status);
        }
    }
}