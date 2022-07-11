public class ClassCustomer {
    public boolean checkbox{get;set;}
    public String customerId{get;set;}
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
	public list<Product2> productLis{get; set;}
	public List<Product2> ProductList =[select id,name,type__c,ProductCode from Product2];
    public  ClassCustomer(){
        Customer__c custom = new Customer__c();
    }
    public List<Product2> getProductList(){
    return     ProductList;
    }
     public void getProducts() {
         if(typePickvalue != '--None--'){
        ProductList = new list<Product2>([select id,name,type__c,ProductCode from Product2 WHERE type__c =: typePickvalue]);
         }
    }
     public PageReference buyProduct() {
        Customer__c custom=new Customer__c(Name=customerName,Date_of_Birth__c=customerDOB,Phone__c=customerPhone,Street__c=customerStreet,City__c=customerCity,Postal_Code__c=customerCode,State__c=customerState,Country__c=customerCountry);
        system.debug('inside createCustomer '+custom);
        insert custom;
        customerId=custom.id;
        System.debug(customerId);

        system.debug('customer id in buy prod is : '+customerId);
        PageReference pgRef = ApexPages.currentPage();
        List<Product2> selectedProducts=new List<Product2>();
        for(Product2 con:ProductList){
            if(con.Is_Selected__c==true){
                selectedProducts.add(con);
            }
        }system.debug('selected Products'+selectedProducts);
        List<Recordtype> recList=[select id,name from recordtype where sObjectType='Bank_Account__c'];
        List<Bank_Account__c> acclist=new List<Bank_Account__c>();
        for(Recordtype rec:recList){
            if(selectedProducts[0].type__c=='Loan'){
                // String
                if(rec.name.contains(selectedProducts[0].type__c)){
                    Id recid=rec.id;
                    Bank_Account__c acc=new Bank_Account__c(Product__c=selectedProducts[0].id,Customer__c=customerId,Name='Mahek',Recordtypeid=recid);
                    acclist.add(acc);

                }
            }
        }
        insert acclist;
        System.debug('accList :: '+acclist);
        pgRef=new PageReference('/'+acclist[0].id);
        return pgRef;
     }

  public PageReference createCustomer() {
        system.debug('inside createCustomer');
        PageReference pgRef = ApexPages.currentPage();
        pgRef = new PageReference('/apex/BuyProductPage');
        pgRef.setRedirect(true);
        return pgRef;
    }
}