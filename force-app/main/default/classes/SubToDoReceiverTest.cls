@isTest
private class SubToDoReceiverTest {

    static Sub_ToDo__c createRecord() {
        ToDo__c testTodo = new ToDo__c(Name = 'Test01',
                                       Category__c = 'Tomorrow',
                                       ExternalId__c = 'a010900000nVG0NAAW');
        insert testTodo;
        Sub_ToDo__c testSubTodo = new Sub_ToDo__c(Name = 'Sub01',
                                                  ToDo__c = testTodo.Id,
                                                  External_Id__c = 'a0009000005U9WwAAK');
        insert testSubTodo;
        return testSubTodo;
    }

    @IsTest
    static void testCreateSub() {
        RestRequest request = new RestRequest();
        createRecord();
        ToDo__c todo = [SELECT Id FROM ToDo__c LIMIT 1];
        request.requestBody = Blob.valueOf(
            '[ { "relatedTodo" : "a010900000nVG0NAAW",  "name" : "Sub01", "status" :"Ready to Take", "id" : "a0009000005U9WwAAK" } ]'
            );
        RestContext.request = request;
        List<Id> ids = SubToDoReceiver.createSub();
        System.assert(ids != null);
        List<Sub_ToDo__c> subs = [SELECT Name FROM Sub_ToDo__c WHERE Id IN :ids];
        System.assert(subs.size() == 1);
        System.assertEquals(subs.get(0).Name, 'Sub01');
    }

    @IsTest
    static void testUpdateSub() {
        Sub_ToDo__c sub = createRecord();
        System.assert(sub != null);
        System.assertEquals(sub.Name, 'Sub01');
        RestRequest request = new RestRequest();
        request.requestBody = Blob.valueOf('[{"relatedTodo" : "a010900000nVG0NAAW",  "name": "Sub02", "status" :"Ready to Take", "id":"' + sub.External_Id__c + '"}]');
        RestContext.request = request;
        List<Id> ids = SubToDoReceiver.updateSub();
        System.assert(ids != null);
        Sub_ToDo__c updatedSub = [SELECT Id, Name FROM Sub_ToDo__c WHERE Id = :sub.Id];
        System.assert(updatedSub != null);
        System.assertEquals(updatedSub.Name, 'Sub02');
    }

    @IsTest
    static void testDeleteSub() {
        Sub_ToDo__c sub = createRecord();
        System.assert(sub != null);
        System.assertEquals(sub.Name, 'Sub01');
        RestRequest request = new RestRequest();
        request.requestBody = Blob.valueOf('[{"relatedTodo" : "a010900000nVG0NAAW",  "name": "Sub01", "status" :"Ready to Take", "id":"' + sub.External_Id__c + '"}]');
        RestContext.request = request;
        List<Sub_ToDo__c> subs = [SELECT Id FROM Sub_ToDo__c];
        System.assert(subs.size() == 1);
        List<Id> deletedIds = SubToDoReceiver.deleteSub();
        System.assert(deletedIds != null);
        List<Sub_ToDo__c> deletedSubs = [SELECT Id FROM Sub_ToDo__c];
        System.assert(deletedSubs.size() == 0);
    }
}