public class TriggerHandler {
    static List<Warehouse__c> newWarehouses = new List<Warehouse__c>();
    
    public static Warehouse__c getFirst(List<Warehouse__c> warehouses, Date addedDate) {
        for(Warehouse__c warehouse : warehouses){
            if(warehouse.Period_Start__c <= addedDate && warehouse.Period_End__c >= addedDate){
                return warehouse;
            }
            
        }
        
        Integer periodTerm = Integer.valueOf(Org_Configuration__c.getInstance().Period_Term__c);
        
        Warehouse__c warehouse = new Warehouse__c(Name='Warehouse ' + addedDate + ' ' + addedDate.addDays(periodTerm),
                                                	  Period_Start__c = addedDate,
                                                 	  Period_End__c = addedDate.addDays(periodTerm));
        
        
        newWarehouses.add(warehouse);
        return warehouse;   
    }
    
    
    public static void insertWarehouses(){
        insert newWarehouses;
    }
    
    

}