trigger Customer_Trigger on Customer__c (after update) {
 CustomerTriggerClass obj = new CustomerTriggerClass();
if( Trigger.isAfter && Trigger.isUpdate){
       obj.updateIsActive(Trigger.New, Trigger.OldMap);
    }
}