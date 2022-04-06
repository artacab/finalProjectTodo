@RestResource(UrlMapping='/ToDo__c/*')

global with sharing class ToDoReceiver {
    @HttpPost
    global static List<Id> createTodo() {
        RestRequest request = RestContext.request;
        List<Object> deserializedTodos = (List<Object>)JSON.deserializeUntyped(request.requestBody.toString());
        List<ToDo__c> todos = new List<ToDo__c>();
        List<Id> ids = new List<Id>();
        List<RecordType> recTypes = [SELECT Id, Name FROM RecordType];

        for(Object todo : deserializedTodos) {
            Map<String, Object> todoAdd = (Map<String, Object>)todo;
            String rectypeAdd = (String)todoAdd.get('rectypeName');
            RecordType recType;
            
            for (RecordType rec : recTypes) {
                if (rec.Name == rectypeAdd) {
                    recType = rec;
                }
            }
            
            todos.add(new ToDo__c(
            Name = (String)todoAdd.get('name'),
            Description__c = (String)todoAdd.get('description'),
            Category__c = (String)todoAdd.get('category'),
            Priority__c = (String)todoAdd.get('priority'),
            Status__c = (String)todoAdd.get('status'),
            RecordTypeId = recType.Id,
            ExternalId__c = (String)todoAdd.get('id'))
            );
        }

        insert todos;

        for(ToDo__c todo : todos) {
            ids.add(todo.Id);
            System.debug(todo);
        }

        return ids;
    }

    @HttpPut
    global static List<Id> updateTodo() {
        RestRequest request = RestContext.request;
        List<Object> deserializedTodos = (List<Object>)JSON.deserializeUntyped(request.requestBody.toString());
        List<ToDo__c> todos = new List<ToDo__c>();
        List<Id> externalIds = new List<Id>();
        List<RecordType> recTypes = [SELECT Id, Name FROM RecordType];

        for (Object todo : deserializedTodos) {
            Map<String, Object> todoAdd = (Map<String, Object>)todo;
            String rectypeAdd = (String)todoAdd.get('rectypeName');
            RecordType recType;
            
            for (RecordType rec : recTypes) {
                if (rec.Name == rectypeAdd) {
                    recType = rec;
                }
            }
            
            if((String)todoAdd.get('externalId') != null) {
                todos.add(new ToDo__c(
            	Name = (String)todoAdd.get('name'),
            	Description__c = (String)todoAdd.get('description'),
            	Category__c = (String)todoAdd.get('category'),
            	Priority__c = (String)todoAdd.get('priority'),
                Status__c = (String)todoAdd.get('status'),
                RecordTypeId = recType.Id,
            	ExternalId__c = (String)todoAdd.get('externalId'))
            );
            } else {
                todos.add(new ToDo__c(
            	Name = (String)todoAdd.get('name'),
            	Description__c = (String)todoAdd.get('description'),
            	Category__c = (String)todoAdd.get('category'),
            	Priority__c = (String)todoAdd.get('priority'),
                Status__c = (String)todoAdd.get('status'),
                RecordTypeId = recType.Id,
                ExternalId__c = (String)todoAdd.get('id'))
            );
            }
        }

        for(ToDo__c todo : todos) {
            externalIds.add(todo.ExternalId__c);
            System.debug(todo);
        }

        List<ToDo__c> sourceTodos = [SELECT Id, ExternalId__c
                                     FROM ToDo__c
                                     WHERE Id IN : externalIds
                                     OR ExternalId__c IN : externalIds];
        
        for (ToDo__c todo : todos) {
            for (ToDo__c dataTodo : sourceTodos) {
                if (todo.ExternalId__c == dataTodo.ExternalId__c || todo.Id == dataTodo.ExternalId__c) {
                    todo.Id = dataTodo.Id;
                }
            }
        }

        update todos;
        return externalIds;
    }

    @HttpDelete
    global static List<Id> deleteTodo() {
        RestRequest request = RestContext.request;
        List<Object> deserializedTodos = (List<Object>)JSON.deserializeUntyped(request.requestBody.toString());
        List<ToDo__c> todos = new List<ToDo__c>();
        List<Id> externalIds = new List<Id>();
        List<RecordType> recTypes = [SELECT Id, Name FROM RecordType];
        
        for (Object todo : deserializedTodos) {
            Map<String, Object> todoAdd = (Map<String, Object>)todo;
            String rectypeAdd = (String)todoAdd.get('rectypeName');
            RecordType recType;
            
            for (RecordType rec : recTypes) {
                if (rec.Name == rectypeAdd) {
                    recType = rec;
                }
            }
            
            if((String)todoAdd.get('externalId') != null) {
                todos.add(new ToDo__c(
            	Name = (String)todoAdd.get('name'),
            	Description__c = (String)todoAdd.get('description'),
            	Category__c = (String)todoAdd.get('category'),
            	Priority__c = (String)todoAdd.get('priority'),
                Status__c = (String)todoAdd.get('status'),
                RecordTypeId = recType.Id,
            	ExternalId__c = (String)todoAdd.get('externalId'))
            );
            } else {
                todos.add(new ToDo__c(
            	Name = (String)todoAdd.get('name'),
            	Description__c = (String)todoAdd.get('description'),
            	Category__c = (String)todoAdd.get('category'),
            	Priority__c = (String)todoAdd.get('priority'),
                Status__c = (String)todoAdd.get('status'),
                RecordTypeId = recType.Id,
                ExternalId__c = (String)todoAdd.get('id'))
            );
            }
        }
        
        for(ToDo__c todo : todos) {
            externalIds.add(todo.ExternalId__c);
            System.debug('externalIds: ' + externalIds);
        }
        
        List<ToDo__c> sourceTodos = [SELECT Id, ExternalId__c
                                     FROM ToDo__c
                                     WHERE Id IN : externalIds
                                     OR ExternalId__c IN : externalIds];
        
        for (ToDo__c todo : todos) {
            for (ToDo__c dataTodo : sourceTodos) {
                if (todo.ExternalId__c == dataTodo.ExternalId__c || todo.Id == dataTodo.ExternalId__c) {
                    todo.Id = dataTodo.Id;
                }
            }
        }

        delete sourceTodos;
        return externalIds;
    }
}