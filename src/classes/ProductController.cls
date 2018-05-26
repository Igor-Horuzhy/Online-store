public with sharing class ProductController {
    
    public String email {get; set;}
    public String firstName {get; set;}
    public String lastName {get; set;}
    public Integer units {get; set;}
    
    public void setfirstname(){ 
    }
    
    public void setlastname(){  
    }
    
    public void setemail(){ 
    }
    
    public void setunits(){
    }
    
	public Product_Table__c getProduct(){
        Id productId = apexpages.currentpage().getparameters().get('id');
        
        Product_Table__c product = [SELECT Name, Title__c, Image_Url__c, Units_Available__c, Product_Description__c, Unit_Price__c FROM Product_Table__c where id= :productId];
        
        return product;
    }
    
    public void fetchdata(){
        Product_Table__c product = getProduct();
        product.Units_Available__c = getProduct().Units_Available__c - units;
        if(product.Units_Available__c < 0){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'We are sorry, this amount of items are not available now'));
        }
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Thanks for your order. We will contact you;)'));
        	update product;
        
        	List<Contact> contactsList = Database.query('SELECT FirstName, LastName FROM Contact Where Email = :email limit 1');
        	if(contactsList.size() > 0){
            	contactsList.get(0).FirstName = firstName;
            	contactsList.get(0).LastName = lastName;
            
            	update contactsList.get(0);
        	}
        	else {
        		Contact newContact = new Contact(FirstName = firstName, LastName = lastName, Email = email);
            	contactsList.add(newContact);
        		insert contactsList.get(0);
        	}
            
            Double amount = units * getProduct().Unit_Price__c;
        
        	Order_T__c order = new Order_T__c(Product__c = apexpages.currentpage().getparameters().get('id'),
                                          	Units__c = units,
                                          	Order_Amount__c = amount,
                                          	Contact__c = contactsList.get(0).Id);
        
        	insert order; 
        }
    }
    
 
    
}