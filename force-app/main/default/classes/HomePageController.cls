public class HomePageController {
    
    public List <Car__c> getCars(){
        List<Car__c> cars = Database.query('SELECT Id, Model__c, Showroom__c FROM Car__c');
        return cars;
    }
}