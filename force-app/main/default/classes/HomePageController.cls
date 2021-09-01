public class HomePageController {
	public String colorPickValue { get; set; }
	public String showroomPickValue { get; set; }
	public List<Car__c> carsList { get; set; }

	public void getCars() {
		carsList = new List<Car__c>(
			[
				SELECT Id, Name, Model__c, Color__c, Price__c, Showroom__r.Name, Car_Owner__r.Name
				FROM Car__c
				WHERE Color__c =:colorPickvalue
				AND Showroom__r.Name =:showroomPickValue
			]
		);
		System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>' + carsList);
	}
}
