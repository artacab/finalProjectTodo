public with sharing class SubTriggerHandlerHelper {
    public static Http http = new Http();
    public static HttpRequest request;
    public static HTTPResponse response;
    public static final String URL_SUB = 'callout:TestConAppAPI/services/apexrest/Sub_ToDo__c';

    @Future(callout = true)
    public static void doRequest(String contentBody, String httpMethod) {
        request = new HttpRequest();
        request.setMethod(httpMethod);
        request.setEndpoint(URL_SUB);
        request.setHeader('Content-Type', 'application/json');
        request.setBody(contentBody);
        response = http.send(request);
        System.debug(response.getBody());
    }
    
    public static void pushInserted(List<Sub_ToDo__c> subs) {
        List<ResponseWrapperSub> wrappers = ResponseWrapperSub.doMappingToWrappers(subs);
        doRequest(JSON.serialize(wrappers), 'POST');
    }

    public static void pushUpdated(List<Sub_ToDo__c> subs) {
        List<ResponseWrapperSub> wrappers = ResponseWrapperSub.doMappingToWrappers(subs);
        doRequest(JSON.serialize(wrappers), 'PUT');
    }

    public static void pushDeleted(List<Sub_ToDo__c> subs) {
        List<ResponseWrapperSub> wrappers = ResponseWrapperSub.doMappingToWrappers(subs);
        doRequest(JSON.serialize(wrappers), 'DELETE');
    }
}