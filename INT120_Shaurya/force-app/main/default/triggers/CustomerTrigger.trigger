trigger CustomerTrigger on Customer__c (after update) {
    CustomerTriggerHandler obj = new CustomerTriggerHandler();
if( Trigger.isAfter && Trigger.isUpdate){
       obj.updateIsActive(Trigger.New, Trigger.OldMap);
    }
}