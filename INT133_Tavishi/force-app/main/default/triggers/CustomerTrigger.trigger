trigger CustomerTrigger on Customer__c (after update) {
    CustomTriggerHandler obj = new CustomTriggerHandler();
if( Trigger.isAfter && Trigger.isUpdate){
       obj.updateIsActive(Trigger.New, Trigger.OldMap);
    }
}