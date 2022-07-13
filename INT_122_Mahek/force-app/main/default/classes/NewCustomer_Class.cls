public class NewCustomer_Class {
    public String customerName {get; set;}
    public Boolean errorOnPage {get; set;}
    public String customerPhone {get; set;}
    public Date customerDOB {get; set;}
    public String customerStreet {get; set;}
    public String customerCity {get; set;}
    public String customerCode {get; set;}
    public String customerState {get; set;}
    public String customerCountry {get; set;}
    public string typePickvalue{get; set;}
    public boolean checkbox{get;set;}
    public String customerId{get;set;}
    public list<Customer__c> custList{get; set;}
    public List<Product2> ProductList =[select id,name,type__c,Is_Selected__c,ProductCode from Product2];
    public  NewCustomer_Class(){
        Customer__c cust=new Customer__c();
    }
    public List<Product2> getProductList(){
        return     ProductList;
    }
    public void getProducts() {
        if(typePickvalue != '--None--'){
            ProductList = new list<Product2>([select id,name,type__c,Is_Selected__c,ProductCode from Product2 WHERE type__c =: typePickvalue]);
        }
    }
    
    public PageReference buyProduct() {
        String query='';
        query=ApexPages.currentPage().getParameters().get('id');
        system.debug('g='+query);
        CustList = new List<Customer__c>([select id,name from customer__c where id=:query]);
        PageReference pgRef = ApexPages.currentPage();
        List<Product2> selectedProducts=new List<Product2>();
        for(Product2 con:ProductList){
            if(con.Is_Selected__c==true){
                selectedProducts.add(con);
            }
        }
        system.debug('selected Products'+selectedProducts);
        Map<Id,String> prodIdTypeMap =new Map<Id,String>();
        for(Product2 pod: selectedProducts){
            prodIdTypeMap.put(pod.id,pod.Type__c);
        }
        List<Recordtype> recList=[select id,name from recordtype where sObjectType='Bank_Account__c'];
        List<Bank_Account__c> acclist=new List<Bank_Account__c>();
        for(Id pid:prodIdTypeMap.keySet()){
            String ptype=prodIdTypeMap.get(pid);
            for(Recordtype rec:recList)
            {
                if(rec.name.contains(ptype))
                {
                    Id recid=rec.id;
                    Bank_Account__c acc=new Bank_Account__c(Name=custList[0].name,Product__c=selectedProducts[0].id,Customer__c=custList[0].id,Recordtypeid=recid,Amount__c=10000);
                    acclist.add(acc);
                    break;   
                }
                else if(ptype=='Account'){
                    Bank_Account__c acc=new Bank_Account__c(Name=custList[0].name,Product__c=selectedProducts[0].id,Customer__c=custList[0].id,Amount__c=10000);
                    acclist.add(acc);
                    break;
                }
            }
        }
        insert acclist;
        System.debug('accList :: '+acclist);
        pgRef=new PageReference('/'+acclist[0].id);
        return pgRef;
    }
    
    public PageReference createCustomer() {
        Customer__c cust=new Customer__c(Name=customerName,Date_of_Birth__c=customerDOB,Phone__c=customerPhone,Street__c=customerStreet,City__c=customerCity,Postal_Code__c=customerCode,State__c=customerState,Country__c=customerCountry);
        system.debug('inside createCustomer '+cust);
        insert cust;
        system.debug('inside createCustomer');
        PageReference pgRef = ApexPages.currentPage();
        pgRef = new PageReference('/apex/BuyProductPage?id='+cust.Id) ;
        pgRef.setRedirect(true);
        return pgRef;
        
        
    }
}