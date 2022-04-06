global class CleanOldTodoSchedule implements Schedulable {
   global void execute(SchedulableContext sc) {
   		CleanOldTodo cleanTodo = new CleanOldTodo();
      	Database.executeBatch(cleanTodo);
   }
}