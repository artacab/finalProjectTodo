public class QueueTriggerHandlerHelper {
	public static void assignmentQueue(List<ToDo__c> todos) {
        List<Group> queues = [SELECT id, name FROM Group WHERE Type = 'Queue'];
        List<RecordType> recTypes = [SELECT Id, Name FROM RecordType LIMIT 3];

        for(ToDo__c todo : todos) {
            string recordtypeName =
            Schema.SObjectType.ToDo__c.getRecordTypeInfosById().get(todo.recordtypeid).getname();
            
            if(recordtypeName == 'Today') {
                for(Group queue : queues) {
                    if(queue.Name == 'Today ToDos' && todo.OwnerId != queue.Id) {
                        todo.OwnerId = queue.Id;
                    }
                }
            }

            else if(recordtypeName == 'Tomorrow') {
                for(Group queue : queues) {
                    if(queue.Name == 'Tomorrow ToDos' && todo.OwnerId != queue.Id) {
                        todo.OwnerId = queue.Id;
                    }
                }
            }

            else if(recordtypeName == 'Later') {
                for(Group queue : queues) {
                    if(queue.Name == 'Later ToDos' && todo.OwnerId != queue.Id) {
                        todo.OwnerId = queue.Id;
                    }
                }
            }
        }
    }
}