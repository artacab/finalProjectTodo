@isTest
private class CleanOldTodoScheduleTest {
    @isTest static void testExecute() {        
        test.startTest();
        CleanOldTodoSchedule cleanOld = new CleanOldTodoSchedule();   
        String cron = '0 0 23 * * ?';        
        system.schedule('Test Scheduled', cron, cleanOld);
        test.stopTest();
    }
}