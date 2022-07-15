public class CustomerClass {
	public String customerName {get; set;}
	public Boolean errorOnPage {get; set;}
	public String customerPhone {get; set;}
	public Date customerDOB {get; set;}
    public String customerStreet {get; set;}
    public String customerCity {get; set;}
    public long customerCode {get; set;}
    public String customerAddress {get; set;}
    public String customerCountry {get; set;}
    public string typePickvalue{get; set;}
    public boolean checkbox{get;set;}
    public id customerId{get;set;}
	public list<Customers__c> customerList{get; set;}
	public List<Product2> ProductList =[select id,name,type__c,IsSelected__c,ProductCode from Product2];
	public  CustomerClass()
    {
        Customers__c customList=new Customers__c();
    }
    public List<Product2> getProductList()
    {
    	return ProductList;
    }
     public void ShowProducts() 
     {
         if(typePickvalue != '--None--')
         {
        	ProductList = new list<Product2>([select id,name,type__c,IsSelected__c,ProductCode from Product2 WHERE type__c =: typePickvalue]);
         }
    }
    public PageReference GetItem() 
    {
        String queryString='';
        queryString=ApexPages.currentPage().getParameters().get('id');
        system.debug('gg='+queryString);
        customerList=new List<Customers__c>([select id,name from customers__c where id=:queryString]);
        PageReference pgRef = ApexPages.currentPage();
        List<Product2> selectedProducts=new List<Product2>();
        for(Product2 res:ProductList)
        {
            if(res.isselected__c==true)
            {
                selectedProducts.add(res);
            }
        }
        Map<Id,String> prodIdTypeMap =new Map<Id,String>();
        for(Product2 pod: selectedProducts){
            prodIdTypeMap.put(pod.id,pod.Type__c);
        }
        List<Recordtype> recordList=[select id,name from recordtype where sObjectType='Bank_Account__c'];
        List<Bank_Account__c> accountlist=new List<Bank_Account__c>();
      for(Id pid:prodIdTypeMap.keySet()){
            String ptype=prodIdTypeMap.get(pid);
            for(Recordtype rec:recordList)
            {
                if(rec.name.contains(ptype))
                {
                    Id recid=rec.id;
                    Bank_Account__c acc=new Bank_Account__c(Name=customerList[0].name,Product__c=selectedProducts[0].id,Customers__c=customerList[0].id,Recordtypeid=recid,Amount__c=10000);
                    accountlist.add(acc);
                    break;   
                }
                else if(ptype=='Account'){
                    Bank_Account__c acc=new Bank_Account__c(Name=customerList[0].name,Product__c=selectedProducts[0].id,Customers__c=customerList[0].id,Amount__c=10000);
                    accountlist.add(acc);
                    break;
                }
            }
        }
        insert accountlist;
        pgRef=new PageReference('/'+accountlist[0].id);
        return pgRef;
    }

 public PageReference createCustomer() 
 	{
          system.debug('inside createCustomer');
          PageReference reference = ApexPages.currentPage();
          Customers__c customList=new Customers__c(Name=customerName,Date_of_Birth__c=customerDOB,Phone__c=customerPhone,Street__c=customerStreet,City__c=customerCity,Zip_Code__c=customerCode,Address__c=customerAddress,Country__c=customerCountry);
          system.debug('inside createCustomer '+customList);
          insert customList;
          customerId=customList.id;
          system.debug(''+customerId);
          reference = new PageReference('/apex/BuyProduct?id='+customerId);
          reference.setRedirect(true);
          return reference;
    }
}