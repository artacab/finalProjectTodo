@RestResource(UrlMapping='/Sub_ToDo__c/*')

global with sharing class SubToDoReceiver {
    @HttpPost
    global static List<Id> createSub() {
        RestRequest request = RestContext.request;
        List<Object> deserializedSubs = (List<Object>) JSON.deserializeUntyped(request.requestBody.toString());
        List<Sub_ToDo__c> subs = new List<Sub_ToDo__c>();
        List<Id> ids = new List<Id>();
        List<Id> todoIds = new List<Id>();

        for (Object sub : deserializedSubs) {
            Map<String, Object> subAdd = (Map<String, Object>)sub;
            if((String)subAdd.get('relatedExternal') != null) {
                todoIds.add((String)subAdd.get('relatedExternal'));
            	subs.add(new Sub_ToDo__c(
            	Name = (String)subAdd.get('name'),
                Status__c = (Boolean)subAdd.get('status'),
            	ToDo__c = (String)subAdd.get('relatedExternal'),
            	External_Id__c = (Id)subAdd.get('id'))
        		);
                System.debug('relatedTodo ' + (Id)subAdd.get('relatedTodo'));
                System.debug('relatedExternal ' + (String)subAdd.get('relatedExternal'));
            } else {
                todoIds.add((Id)subAdd.get('relatedTodo'));
            	subs.add(new Sub_ToDo__c(
            	Name = (String)subAdd.get('name'),
                Status__c = (Boolean)subAdd.get('status'),
            	ToDo__c = (Id)subAdd.get('relatedTodo'),
            	External_Id__c = (Id)subAdd.get('id'))
        		);
                System.debug('relatedTodo ' + (Id)subAdd.get('relatedTodo'));
                System.debug('relatedExternal ' + (String)subAdd.get('relatedExternal'));
            }
        }

        List<ToDo__c> todos = [SELECT Id, ExternalId__c
                               FROM ToDo__c
                               WHERE ExternalId__c IN : todoIds
                               OR Id IN : todoIds];
        System.debug(todos);

        for (Sub_ToDo__c sub : subs) {
            for (ToDo__c todo : todos) {
                sub.ToDo__c = todo.Id;
            }
        }

        insert subs;

        for (Sub_ToDo__c sub : subs) {
            ids.add(sub.Id);
            System.debug(sub);
        }

        return ids;
    }

    @HttpPut
    global static List<Id> updateSub() {
        RestRequest request = RestContext.request;
        List<Object> deserializedSubs = (List<Object>) JSON.deserializeUntyped(request.requestBody.toString());
        List<Sub_ToDo__c> subs = new List<Sub_ToDo__c>();
        List<Id> todoIds = new List<Id>();
        
        for (Object sub : deserializedSubs) {
            Map<String, Object> subAdd = (Map<String, Object>)sub;
            
            if((String)subAdd.get('relatedExternal') != null) {
                todoIds.add((String)subAdd.get('relatedExternal'));
                
                if((String)subAdd.get('externalId') != null) {
                    subs.add(new Sub_ToDo__c(
            		Name = (String)subAdd.get('name'),
                    Status__c = (Boolean)subAdd.get('status'),
            		ToDo__c = (String)subAdd.get('relatedExternal'),
            		External_Id__c = (Id)subAdd.get('externalId'))
        			);
                    System.debug('If relatedExternal != null && externalId != null: ' + subs);
                } else {
                    subs.add(new Sub_ToDo__c(
            		Name = (String)subAdd.get('name'),
                    Status__c = (Boolean)subAdd.get('status'),
            		ToDo__c = (String)subAdd.get('relatedExternal'),
            		External_Id__c = (Id)subAdd.get('id'))
        			);
                    System.debug('If relatedExternal != null && externalId == null: ' + subs);
                }
            	
                System.debug('relatedTodo ' + (Id)subAdd.get('relatedTodo'));
                System.debug('relatedExternal ' + (String)subAdd.get('relatedExternal'));
            } else {
                todoIds.add((Id)subAdd.get('relatedTodo'));
                if((String)subAdd.get('externalId') != null) {
                    subs.add(new Sub_ToDo__c(
            		Name = (String)subAdd.get('name'),
                    Status__c = (Boolean)subAdd.get('status'),
            		ToDo__c = (Id)subAdd.get('relatedTodo'),
            		External_Id__c = (Id)subAdd.get('externalId'))
        			);
                    System.debug('If relatedExternal == null && externalId != null: ' + subs);
                } else {
                    subs.add(new Sub_ToDo__c(
            		Name = (String)subAdd.get('name'),
                    Status__c = (Boolean)subAdd.get('status'),
            		ToDo__c = (Id)subAdd.get('relatedTodo'),
            		External_Id__c = (Id)subAdd.get('id'))
        			);
                    System.debug('If relatedExternal == null && externalId == null: ' + subs);
                }
            	
                System.debug('relatedTodo ' + (Id)subAdd.get('relatedTodo'));
                System.debug('relatedExternal ' + (String)subAdd.get('relatedExternal'));
            }
        }
        
        for (Sub_ToDo__c sub : subs) {
            todoIds.add(sub.External_Id__c);
        }

        List<Sub_ToDo__c> sourceSubs = [SELECT Id, External_Id__c, ToDo__r.Id
                                        FROM Sub_ToDo__c
                                        WHERE External_Id__c IN : todoIds
                                        OR Id IN : todoIds];

        for (Sub_ToDo__c sub : subs) {
            for (Sub_ToDo__c sourceSub : sourceSubs) {
                if (sub.External_Id__c == sourceSub.External_Id__c || sub.Id == sourceSub.External_Id__c) {
                    sub.Id = sourceSub.Id;
                    sub.ToDo__r = sourceSub.ToDo__r;
                }
            }
        }

        update subs;
        return todoIds;
    }

    @HttpDelete
    global static List<Id> deleteSub() {
        RestRequest request = RestContext.request;
        List<Object> deserializedSubs = (List<Object>) JSON.deserializeUntyped(request.requestBody.toString());
        List<Sub_ToDo__c> subs = new List<Sub_ToDo__c>();
        List<Id> todoIds = new List<Id>();
        
        for (Object sub : deserializedSubs) {
            Map<String, Object> subAdd = (Map<String, Object>)sub;
            
            if((String)subAdd.get('relatedExternal') != null) {
                todoIds.add((String)subAdd.get('relatedExternal'));
                
                if((String)subAdd.get('externalId') != null) {
                    subs.add(new Sub_ToDo__c(
            		Name = (String)subAdd.get('name'),
                    Status__c = (Boolean)subAdd.get('status'),
            		ToDo__c = (String)subAdd.get('relatedExternal'),
            		External_Id__c = (Id)subAdd.get('externalId'))
        			);
                    System.debug('If relatedExternal != null && externalId != null: ' + subs);
                } else {
                    subs.add(new Sub_ToDo__c(
            		Name = (String)subAdd.get('name'),
                    Status__c = (Boolean)subAdd.get('status'),
            		ToDo__c = (String)subAdd.get('relatedExternal'),
            		External_Id__c = (Id)subAdd.get('id'))
        			);
                    System.debug('If relatedExternal != null && externalId == null: ' + subs);
                }
            	
                System.debug('relatedTodo ' + (Id)subAdd.get('relatedTodo'));
                System.debug('relatedExternal ' + (String)subAdd.get('relatedExternal'));
            } else {
                todoIds.add((Id)subAdd.get('relatedTodo'));
                if((String)subAdd.get('externalId') != null) {
                    subs.add(new Sub_ToDo__c(
            		Name = (String)subAdd.get('name'),
                    Status__c = (Boolean)subAdd.get('status'),
            		ToDo__c = (Id)subAdd.get('relatedTodo'),
            		External_Id__c = (Id)subAdd.get('externalId'))
        			);
                    System.debug('If relatedExternal == null && externalId != null: ' + subs);
                } else {
                    subs.add(new Sub_ToDo__c(
            		Name = (String)subAdd.get('name'),
                    Status__c = (Boolean)subAdd.get('status'),
            		ToDo__c = (Id)subAdd.get('relatedTodo'),
            		External_Id__c = (Id)subAdd.get('id'))
        			);
                    System.debug('If relatedExternal == null && externalId == null: ' + subs);
                }
            	
                System.debug('relatedTodo ' + (Id)subAdd.get('relatedTodo'));
                System.debug('relatedExternal ' + (String)subAdd.get('relatedExternal'));
            }
        }
        
        for (Sub_ToDo__c sub : subs) {
            todoIds.add(sub.External_Id__c);
        }

        List<Sub_ToDo__c> sourceSubs = [SELECT Id, External_Id__c, ToDo__r.Id
                                        FROM Sub_ToDo__c
                                        WHERE External_Id__c IN : todoIds
                                        OR Id IN : todoIds];

        for (Sub_ToDo__c sub : subs) {
            for (Sub_ToDo__c sourceSub : sourceSubs) {
                if (sub.External_Id__c == sourceSub.External_Id__c || sub.Id == sourceSub.External_Id__c) {
                    sub.Id = sourceSub.Id;
                    sub.ToDo__r = sourceSub.ToDo__r;
                }
            }
        }
        delete subs;
        return todoIds;
    }
}