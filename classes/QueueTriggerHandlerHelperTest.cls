@isTest
private class QueueTriggerHandlerHelperTest {
    static ToDo__c createRecord(String name, String recId) {
        return new ToDo__c(
        	Name = name,
            Status__c = 'Ready to take',
            RecordTypeId = recId
        );
    }
    @isTest static void testAssignmentQueue() {
        Group queue = [SELECT id, Name FROM Group WHERE Type = 'Queue' AND Name = 'Today ToDos'];
        ToDo__c todo = createRecord('Test01', 'a028c00000Xbqk3AAB');
        System.debug('todo: ' + todo);
        System.debug('todo.RecID: ' + todo.RecordTypeId);
        List<ToDo__c> todos1 = new List<ToDo__c>();
        todos1.add(todo);
        System.debug('todos1: ' + todos1);
        QueueTriggerHandlerHelper.assignmentQueue(todos1);
        System.debug(todo.OwnerId);
        System.assertEquals(todo.OwnerId, queue.Id);
        
        queue = [SELECT id, Name FROM Group WHERE Type = 'Queue' AND Name = 'Tomorrow ToDos'];
        todo = createRecord('Test02', 'a028c00000XbzxuAAB');
        System.debug('todo: ' + todo);
        List<ToDo__c> todos2 = new List<ToDo__c>();
        todos2.add(todo);
        System.debug('todos2: ' + todos2);
        QueueTriggerHandlerHelper.assignmentQueue(todos2);
        System.debug(todo.OwnerId);
        System.assertEquals(todo.OwnerId, queue.Id);
        
        queue = [SELECT id, Name FROM Group WHERE Type = 'Queue' AND Name = 'Later ToDos'];
        todo = createRecord('Test03', 'a028c00000XbzxvAAB');
        System.debug('todo: ' + todo);
        List<ToDo__c> todos3 = new List<ToDo__c>();
        todos3.add(todo);
        System.debug('todos3: ' + todos3);
        QueueTriggerHandlerHelper.assignmentQueue(todos3);
        System.debug(todo.OwnerId);
        System.assertEquals(todo.OwnerId, queue.Id);
    }
}