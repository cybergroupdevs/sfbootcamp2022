public class customer_page {
	public String customerName {get; set;}
	public Boolean errorOnPage {get; set;}
	public String customerPhone {get; set;}
	public Date customerDOB {get; set;}
    public String customerStreet {get; set;}
    public String customerCity {get; set;}
    public Integer customerCode {get; set;}
    public String customerState {get; set;}
    public String customerCountry {get; set;}
    public string typePickvalue{get; set;}
    public ID customerId {get; set;}
    public boolean isSelected{get; set;}
	public list<Product2> productLis{get; set;}
    
    public list<Customer__c> customerList{get; set;}
	public List<Product2> ProductList =[select id,name,type__c, IsSelected__c ,ProductCode from Product2];
    public  customer_page(){
        Customer__c custom=new Customer__c();
    }
    public List<Product2> getProductList(){
    	return ProductList;
    }
     public void getProducts() {
         if(typePickvalue != '--None--'){
        ProductList = new list<Product2>([select id,name,type__c, IsSelected__c ,ProductCode from Product2 WHERE type__c =: typePickvalue]);
         }
    }
    public PageReference buyNewProduct() {
        String query='';
        query=ApexPages.currentPage().getParameters().get('id');
        system.debug('g='+query);
        CustomerList = new List<Customer__c>([select id,name from customer__c where id=:query]);
        PageReference pgRef = ApexPages.currentPage();
        List<Product2> selectedProducts=new List<Product2>();
        for(Product2 con:ProductList){
            if(con.IsSelected__c==true){
                selectedProducts.add(con);
            }
        }
        Map<Id,String> prodIdTypeMap =new Map<Id,String>();
        for(Product2 pod: selectedProducts){
            prodIdTypeMap.put(pod.id,pod.Type__c);
        }
        List<Recordtype> recList=[select id,name from recordtype where sObjectType='Bank_Account__c'];
        List<Bank_Account__c> accountList=new List<Bank_Account__c>();
        for(Id pid:prodIdTypeMap.keySet()){
            String ptype=prodIdTypeMap.get(pid);
            for(Recordtype rec:recList){            
               if(rec.name.contains(ptype))
                {
                    Id recid=rec.id;
                    Bank_Account__c acc=new Bank_Account__c(Name=customerList[0].name,Product__c=selectedProducts[0].id,Customer__c=customerList[0].id,Recordtypeid=recid);
                    accountList.add(acc);
                    break;
                }
             else if(ptype=='Account'){
                  Bank_Account__c acc=new Bank_Account__c(Name=customerList[0].name,Product__c=selectedProducts[0].id,Customer__c=customerList[0].id);
                    accountList.add(acc);
                 break;
            }
        }
        }
        
        insert accountList;
        pgRef=new PageReference('/'+accountList[0].id);
        return pgRef;
    }

 public PageReference createNewCustomer() {
     PageReference pgRef = ApexPages.currentPage();
         Customer__c customer =new Customer__c(Name=customerName,Date_of_Birth__c=customerDOB,Phone__c=customerPhone,Street__c=customerStreet,City__c=customerCity,Postal_Code__c=customerCode,State__c=customerState,Country__c=customerCountry);
          insert customer;
            pgRef = new PageReference('/apex/BuyProduct?id='+customer.Id);
            pgRef.setRedirect(true);
            return pgRef;
      }
}