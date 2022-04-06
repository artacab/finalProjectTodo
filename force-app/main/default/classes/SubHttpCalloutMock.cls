@isTest
global class SubHttpCalloutMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json;charset=UTF-8');
        response.setBody('{"Id" : "a010900000obuFnAAI", "Name" : "Test 0001"}');
        response.setStatusCode(200);
        return response;
    }
}