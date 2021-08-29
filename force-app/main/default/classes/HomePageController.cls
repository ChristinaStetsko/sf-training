public class HomePageController {

    List<Car__c> cars;
  
    public List <Car__c> getCars(){
        cars = [SELECT Id, Name, Model__c, Color__c, Price__c, Showroom__r.Name, Car_Owner__r.Name FROM Car__c];
        return cars;
    }
}