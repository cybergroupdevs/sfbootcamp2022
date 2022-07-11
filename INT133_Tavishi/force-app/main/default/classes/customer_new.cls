public class customer_new {
public String customerName {get; set;}
public Boolean errorOnPage {get; set;}
public String customerPhone {get; set;}
public Date customerDOB {get; set;}
    public String customerHouseNo {get; set;}
    public String customerStreet {get; set;}
    public String customerCity {get; set;}
    public String customerCode {get; set;}
    public String customerCountry {get; set;}
    public string typePickvalue{get; set;}
public list<Product2> productLis{get; set;}
public List<Product2> ProductList =[select id,name,type__c,ProductCode from Product2];
    public  customer_new(){
        Customer__c custom=new Customer__c();
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
         PageReference pgRef = ApexPages.currentPage();

            return null;
     }

 public PageReference createCustomer() {
          system.debug('inside createCustomer');
            PageReference pgRef = ApexPages.currentPage();
         Customer__c custom=new Customer__c(Name=customerName,Date_of_Birth__c=customerDOB,Phone__c=customerPhone,HouseNo__c=customerHouseNo,Street__c=customerStreet,City__c=customerCity,Postal_Code__c=customerCode,Country__c=customerCountry);
          system.debug('inside createCustomer '+custom);
          insert custom;
            pgRef = new PageReference('/apex/BuyProduct');
            pgRef.setRedirect(true);
            return pgRef;


      }
}