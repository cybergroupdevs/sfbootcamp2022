public class CustomerTriggerHandler {
public void updateIsActive(list<Customer__c> customerList,Map<Id,Customer__c> oldmap){

        List<Id> custIds=new List<Id>();
        for(Customer__c cust:customerList){
            Customer__c oldcust=oldmap.get(cust.id);
            if(oldcust.Active__c!=cust.Active__c){
                system.debug('oldcust.Active__c '+oldcust.Active__c);
                system.debug('cust.Active__c '+cust.Active__c);
                if(cust.Active__c==false){
                custIds.add(cust.id);
                }
            }
        }
         List<Customer__c> custlsushd=new List<Customer__c>();
        Boolean  isLoan=false;
         system.debug('custIds '+custIds);
        for(Customer__c cus: [select Name,Active__c,(select Name,RecordtypeId,Recordtype.name,balance__c from Bank_accounts__r) from Customer__c where id IN : custIds])
        {  
            system.debug('cus '+cus);
            for(Bank_account__c bankAc:cus.Bank_accounts__r){
                 system.debug('bankAc '+bankAc);
                 system.debug('bankAc.Recordtype '+bankAc.Recordtype.name);
                if(bankAc.Recordtype.name=='Loan' && bankAc.balance__c==0){
                      system.debug('bankAc.Recordtype '+bankAc.Recordtype);
                    isLoan=true;
                   // bankAc.customers__r.Active__c=false;
                }  
            }
            if(isLoan){
               cus.Active__c=false;
                custlsushd.add(cus);
            }
            else{
                cus.Active__c=true;
                custlsushd.add(cus);
                Trigger.new[0].addError('You have a pending balance to mark yourself inactive make the balance 0');
                System.debug('error');
            }
        }
        update custlsushd;
         }
}