@isTest
global class TodoHttpCalloutMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json;charset=UTF-8');
        response.setBody('{"Id" : "a0009000007RU4WAAW", "Name" : "Test 0001"}');
        response.setStatusCode(200);
        return response;
    }
}