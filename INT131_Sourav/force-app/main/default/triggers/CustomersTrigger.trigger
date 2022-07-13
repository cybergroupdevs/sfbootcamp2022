trigger CustomersTrigger on Customers__c (after update) {
    CustomersTriggerHandler obj = new CustomersTriggerHandler();
if( Trigger.isAfter && Trigger.isUpdate){
       obj.updateIsActive(Trigger.New, Trigger.OldMap);
    }
}