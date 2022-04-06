@isTest
private class QueueTriggerHandlerHelperTest {
    static ToDo__c createRecord(String name, String recId) {
        return new ToDo__c(
        	Name = name,
            Status__c = 'Ready to take',
            RecordTypeId = recId
        );
    }
    @isTest static void testAssignmentQueueToday() {
        Group queue = [SELECT id, Name FROM Group WHERE Type = 'Queue' AND Name = 'Today ToDos'];
        ToDo__c todo = createRecord('Test01', '0125j000000MwLPAA0');
        System.debug('todo: ' + todo);
        System.debug('todo.RecID: ' + todo.RecordTypeId);
        List<ToDo__c> todos1 = new List<ToDo__c>();
        todos1.add(todo);
        System.debug('todos1: ' + todos1);
        QueueTriggerHandlerHelper.assignmentQueue(todos1);
        System.debug(todo.OwnerId);
        System.assertEquals(todo.OwnerId, queue.Id);
    }
    @isTest static void testAssignmentQueueTomorrow() {
        Group queue = [SELECT id, Name FROM Group WHERE Type = 'Queue' AND Name = 'Tomorrow ToDos'];
        ToDo__c todo = createRecord('Test01', '0125j000000MwLQAA0');
        System.debug('todo: ' + todo);
        System.debug('todo.RecID: ' + todo.RecordTypeId);
        List<ToDo__c> todos1 = new List<ToDo__c>();
        todos1.add(todo);
        System.debug('todos1: ' + todos1);
        QueueTriggerHandlerHelper.assignmentQueue(todos1);
        System.debug(todo.OwnerId);
        System.assertEquals(todo.OwnerId, queue.Id);
    }
    @isTest static void testAssignmentQueueLater() {
        Group queue = [SELECT id, Name FROM Group WHERE Type = 'Queue' AND Name = 'Later ToDos'];
        ToDo__c todo = createRecord('Test01', '0125j000000MwLOAA0');
        System.debug('todo: ' + todo);
        System.debug('todo.RecID: ' + todo.RecordTypeId);
        List<ToDo__c> todos1 = new List<ToDo__c>();
        todos1.add(todo);
        System.debug('todos1: ' + todos1);
        QueueTriggerHandlerHelper.assignmentQueue(todos1);
        System.debug(todo.OwnerId);
        System.assertEquals(todo.OwnerId, queue.Id);
    }
}