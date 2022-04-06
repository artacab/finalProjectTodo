@isTest
private class CleanOldTodoTest {
    static void setup() {
        Date dt = Date.today() - 95;
        ToDo__c todo = new ToDo__c(Name = 'Test01');
        insert todo;
        Test.setCreatedDate(todo.Id, dt);
        update todo;
    }

    @IsTest static void testExecute() {
        Test.startTest();
        CleanOldTodo batch = new CleanOldTodo();
        Id batchId = Database.executeBatch(batch);
        
        Test.stopTest();
        List<ToDo__c> oldTodos = [SELECT Id FROM ToDo__c WHERE CreatedDate = LAST_90_DAYS];
        System.assertEquals(0, oldTodos.size());
    }
}