public class CarDetailController {
	public Car__c singleCar { get; set; }

	public CarDetailController() {
		Id id = Apexpages.currentPage().getParameters().get('id');
		singleCar = [
			SELECT
				Id,
				Name,
				Car_Owner__r.Name,
				Color__c,
				Model__c,
				Price__c,
				Showroom__r.Name,
				OwnerId,
				(SELECT Id, Scheduled_date__c FROM Maintenances__r)
			FROM Car__c
			WHERE Id = :id
		];
		System.debug('>>>>>>>>>>>>>>>> Single car:' + singleCar);
	}

	public PageReference forwardToHomePage() {
		return new PageReference('/HomePage');
	}
	
}
