public with sharing class ResponseWrapperSub {

    public String id { get; set; }
    public String name { get; set; }
    public String status { get; set; }
    public String relatedTodo { get; set; }
    public String relatedExternal { get; set; }
    public String externalId { get; set; }

    public static ResponseWrapperSub doMapping(Sub_ToDo__c sub) {
        ResponseWrapperSub wrapper = new ResponseWrapperSub();
        wrapper.id = sub.Id;
        wrapper.name = sub.Name;
        wrapper.status = sub.Status__c;
        wrapper.relatedTodo = sub.ToDo__c;
        for(ToDo__c todo : [SELECT Id, ExternalId__c FROM ToDo__c]) {
            if(todo.Id == wrapper.relatedTodo) {
                wrapper.relatedExternal = todo.ExternalId__c;
            }
        }
        // wrapper.relatedExternal = sub.ToDo__r.ExternalId__c;
        wrapper.externalId = sub.External_Id__c;
        return wrapper;
    }

    public static List<ResponseWrapperSub> doMappingToWrappers(List<Sub_ToDo__c> subs){
        List<ResponseWrapperSub> wrappers = new List<ResponseWrapperSub>();

        for (Sub_ToDo__c sub: subs) {
            ResponseWrapperSub wrapper = doMapping(sub);
            wrappers.add(wrapper);
        }

        return wrappers;
    }
}