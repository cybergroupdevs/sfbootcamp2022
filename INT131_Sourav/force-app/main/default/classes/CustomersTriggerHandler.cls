public class CustomersTriggerHandler 
{
    public void updateIsActive(list<Customers__c> customList,Map<Id,Customers__c> oldmap)
    {
        List<Id> custIds=new List<Id>();
        for(Customers__c cust:customList)
        {
            Customers__c oldcust=oldmap.get(cust.id);
            if(oldcust.Active__c!=cust.Active__c)
            {
                system.debug('oldcust.Active__c '+oldcust.Active__c);
                system.debug('cust.Active__c '+cust.Active__c);
                if(cust.Active__c==false)
                {
                    custIds.add(cust.id);
                }
            }
        }
        List<Customers__c> custlsushd=new List<Customers__c>();
        Boolean  isLoan=false;
        system.debug('custIds '+custIds);
        for(Customers__c cus: [select Name,Active__c,(select Name,RecordtypeId,Recordtype.name,loan_balance__c from Bank_accounts__r) from Customers__c where id IN : custIds])
        {  
            system.debug('cus '+cus);
            for(Bank_account__c bankAc:cus.Bank_accounts__r)
            {
                system.debug('bankAc '+bankAc);
                system.debug('bankAc.Recordtype '+bankAc.Recordtype.name);
                if(bankAc.Recordtype.name=='Loan' && bankAc.loan_balance__c==0)
                {
                    system.debug('bankAc.Recordtype '+bankAc.Recordtype);
                    isLoan=true;
                }  
            }
            if(isLoan)
            {
                system.debug('inside siififf');
                cus.Active__c=false;
                custlsushd.add(cus);
            }
            else
            {
                cus.Active__c=true;
                custlsushd.add(cus);                
	            Trigger.new[0].addError('You have a pending loan Balance,To make yourself inactive your loan balance should be zero');
                System.debug('error');
            }
        }
        update custlsushd;
    }
}