trigger assignWarehouse on Product_Table__c (before insert) {
	List<Warehouse__c> warehouses = [SELECT Id, Period_Start__c, Period_End__c FROM Warehouse__c];
    Map<Product_Table__c, Warehouse__c> productToWarehouse = new Map<Product_Table__c, Warehouse__c>();
    
    for(Product_Table__c product : Trigger.new){
        if(product.Added_Date__c == null){
            product.Added_Date__c = Date.today();
        }
        
        Warehouse__c warehouse = TriggerHandler.getFirst(warehouses, product.Added_Date__c);
        
        productToWarehouse.put(product, warehouse);
        
    }
    
    TriggerHandler.insertWarehouses();
    
    for(Product_Table__c product : productToWarehouse.keySet()){
		product.Warehouse__c = productToWarehouse.get(product).Id;        
    }
    
    
}