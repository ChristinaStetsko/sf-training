public class ScheduleController {
	public Maintenance__c maintenance { get; set; }
	public Date dateVal { get; set; }
	public Id maintId { get; set; }

	public Car__c singleCar { get; set; }

	public ScheduleController() {
		Id id = Apexpages.currentPage().getParameters().get('id');
		singleCar = [
			SELECT
				Id,
				Name,
				Car_Owner__r.Name,
				Color__c,
				Model__c,
				Price__c,
				Showroom__c,
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

	// public ScheduleController() {
		//Id carId = Apexpages.currentPage().getParameters().get('id');
		//maintenance = [SELECT Id, Showroom__c, Scheduled_date__c, Car__c FROM Maintenance__c WHERE Car__c = :carId];
	// 	getAllCars = [SELECT Id, Name, Model__c, Color__c, Price__c, Showroom__r.Name, Car_Owner__r.Name
	// 	FROM Car__c];
	// 	System.debug('>>>>>>>>>>>>>>>> Single car:' + getAllCars);
	// }

	public PageReference save() {
		return null;
	}

	// public PageReference save() {
	// 	PageReference pageReference = null;

	// 	errorMessage = '';
	// 	error = false;
	// 	Contact ld = (Contact) stdCtrl.getRecord();
	// 	if ((String.isEmpty(ld.Email)) || (String.isEmpty(ld.Password__c))) {
	// 		errorMessage = 'Please enter all required fields';
	// 		error = true;
	// 	} else {
	// 		try {
	// 			insert ld;
	// 			pageReference = Page.HomePage;
	// 			pageReference.getParameters().put('id', ld.id);
	// 			pageReference.setRedirect(true);
	// 		} catch (Exception e) {
	// 			errorMessage = 'An error has occurred: ' + e.getMessage();
	// 			error = true;
	// 		}
	// 	}
	// 	return pageReference;
	// }
}
