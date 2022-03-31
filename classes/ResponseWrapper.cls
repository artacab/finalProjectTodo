public with sharing class ResponseWrapper {
    public String id { get; set; }
    public String name { get; set; }
    public String description { get; set; }
    public Date creationDate { get; set; }
    public String category { get; set; }
    public String priority { get; set; }
    public Boolean status { get; set; }
    public String externalId { get; set; }
    public String rectypeName {get; set;}

    public static ResponseWrapper doMapping(ToDo__c todo) {
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
        return wrapper;
    }

    public static List<ResponseWrapper> doMappingToWrappers(List<ToDo__c> todos){
        List<ResponseWrapper> wrappers = new List<ResponseWrapper>();

        for (ToDo__c todo: todos) {
            ResponseWrapper wrapper = doMapping(todo);
            wrappers.add(wrapper);
        }

        return wrappers;
    }
}