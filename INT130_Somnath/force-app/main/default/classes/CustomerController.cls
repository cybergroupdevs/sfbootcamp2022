public class CustomerController {
	public String customerName {get; set;}
    public Boolean errorOnPage {get; set;}
    public String customerPhone {get; set;}
    public Date customerDOB {get; set;}
    public String customerStreet {get; set;}
    public string customerLocality {get; set;}
    public String customerCity {get; set;}  
    public String customerState {get; set;}
    public String customerCountry {get; set;}
    public string typePickvalue{get; set;}
    public ID customerId {get; set;}
    public boolean isSelected{get; set;}
    public list<Product2> productLis{get; set;}
    public List<Product2> ProductList =[select id,name,type__c, IsSelected__c ,ProductCode from Product2];
    public CustomerController(){
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
        Customer__c custom=new Customer__c(Name=customerName,Date_of_birth__c=customerDOB,Phone__c=customerPhone,Street__c=customerStreet,City__c=customerCity,Locality__c=customerLocality,State__c=customerState,Country__c=customerCountry);
        insert custom;
        customerId=custom.id;
        PageReference pgRef = ApexPages.currentPage();
        List<Product2> selectedProducts=new List<Product2>();
        for(Product2 con:ProductList){
            if(con.IsSelected__c==true){
                selectedProducts.add(con);
            }
        }
        List<Recordtype> recList=[select id,name from recordtype where sObjectType='Bank_Account__c'];
        List<Bank_Account__c> accountList=new List<Bank_Account__c>();
        for(Recordtype rec:recList){              
                if(rec.name.contains('Account')){
                    Id recid=rec.id;
                    Bank_Account__c acc=new Bank_Account__c(Product__c=selectedProducts[0].id,Customer__c=customerId,Name='Somnath',Recordtypeid=recid);
                    accountList.add(acc);

                }            
            else if(rec.name.contains('Loan')){
                    Id recid=rec.id;
                    Bank_Account__c acc=new Bank_Account__c(Product__c=selectedProducts[0].id,Customer__c=customerId,Name='Somnath',Recordtypeid=recid);
                    accountList.add(acc);                
            }
            else if(rec.name.contains('Deposit')){
                    Id recid=rec.id;
                    Bank_Account__c acc=new Bank_Account__c(Product__c=selectedProducts[0].id,Customer__c=customerId,Name='Somnath',Recordtypeid=recid);
                    accountList.add(acc);
                }
        }
        insert accountList;
        pgRef=new PageReference('/'+accountList[0].id);
        return pgRef;
    }

 public PageReference createNewCustomer() {
     PageReference pgRef = ApexPages.currentPage();
         Customer__c customer =new Customer__c(Name=customerName,Date_of_birth__c=customerDOB,Phone__c=customerPhone,Street__c=customerStreet,City__c=customerCity,Locality__c=customerLocality,State__c=customerState,Country__c=customerCountry);
          insert customer;
            pgRef = new PageReference('/apex/ProductsVF');
            pgRef.setRedirect(true);
            return pgRef;
      }
}