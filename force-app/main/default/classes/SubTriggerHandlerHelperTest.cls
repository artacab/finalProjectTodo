@IsTest
private class SubTriggerHandlerHelperTest {
    @IsTest
    static void testPushInserted() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('SubResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, new SubHttpCalloutMock());
        List<Sub_ToDo__c> subs = new List<Sub_ToDo__c>();
        Test.startTest();
        SubTriggerHandlerHelper.pushInserted(subs);
        Integer futureCalls = Limits.getFutureCalls();
        Test.stopTest();
        System.assertEquals(1, futureCalls);
    }

    @IsTest
    static void testpushUpdated() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('SubResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, new SubHttpCalloutMock());
        List<Sub_ToDo__c> subs = new List<Sub_ToDo__c>();
        Test.startTest();
        SubTriggerHandlerHelper.pushUpdated(subs);
        Integer futureCalls = Limits.getFutureCalls();
        Test.stopTest();
        System.assertEquals(1, futureCalls);
    }

    @IsTest
    static void testpushDeleted() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('SubResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, new SubHttpCalloutMock());
        List<Sub_ToDo__c> subs = new List<Sub_ToDo__c>();
        Test.startTest();
        SubTriggerHandlerHelper.pushDeleted(subs);
        Integer futureCalls = Limits.getFutureCalls();
        Test.stopTest();
        System.assertEquals(1, futureCalls);
    }
}