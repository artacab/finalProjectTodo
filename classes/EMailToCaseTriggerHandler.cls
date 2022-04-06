public with sharing class EMailToCaseTriggerHandler {
    public static void onBeforeInsert(List<Case> cases) {
        EMailToCaseTriggerHandlerHelper.createCaseTodo(cases);
    }
}