public class GetProducts {
    public List<Product_Table__c> getProducts(){
        List<Product_Table__c> products = Database.query('SELECT Name, Title__c, Image_Url__c, Product_Description__c, Unit_Price__c FROM Product_Table__c');
        
        return products;
    }
}