public class HomePageController {
	public String MAIN_URL = 'https://issoft48-dev-ed.lightning.force.com/lightning/r/Car__c/';
	// public String MAIN_URL = 'https://energy-connect-4809-dev-ed.lightning.force.com/lightning/r/Car__c/';
	public String colorPickValue { get; set; }
	public String showroomPickValue { get; set; }
	public String recId { get; set; }
	public List<Car__c> getAllCars { get; set; }
	public List<Showroom__c> getAllShowrooms { get; set; }

	public HomePageController() {
		loadData();
	}

	private void loadData() {
		getAllCars = [
			SELECT Id, Name, Model__c, Color__c, Price__c, Showroom__r.Name, Car_Owner__r.Name
			FROM Car__c
			LIMIT 50
		];
	}

	public Pagereference getInfo() {
		PageReference pageReference = null;
		Car__c getCarInfo = null;
		for (Car__c c : getAllCars)
			if (c.Id == recId) {
				getCarInfo = c;
				ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL, 'No such car found'));
				break;
			}
		if (getCarInfo != null) {
			System.debug('>>>>>>>>>>>>>>>> Success:' + getCarInfo);
			return new PageReference(MAIN_URL + recId + '/view');
		}
		return null;
	}

	public Pagereference scheduleService() {
		Car__c sceduleCarService = null;
		for (Car__c c : getAllCars)
			if (c.Id == recId) {
				sceduleCarService = c;
				ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL, 'No such car found'));
				break;
			}
		if (sceduleCarService != null) {
			System.debug('>>>>>>>>>>>>>>>> Success:' + sceduleCarService);
			return new PageReference('/HomePage');
		}
		return null;
	}

	public void getCars() {
		getAllCars = new List<Car__c>(
			[
				SELECT Id, Name, Model__c, Color__c, Price__c, Showroom__r.Name, Car_Owner__r.Name
				FROM Car__c
				WHERE Color__c = :colorPickvalue AND Showroom__r.Name = :showroomPickValue
				// WHERE Showroom__r.Name = :showroomPickValue
				LIMIT 50
			]
		);
		System.debug('1>>>>>>>>>>>>>>>>>>>>>>>>>>>' + getAllCars);
	}

	public List<SelectOption> getSelectColor() {
		List<SelectOption> optionsColor = new List<SelectOption>();
		Schema.DescribeFieldResult colorField = Car__c.Color__c.getDescribe();
		System.debug('2>>>>>>>>>>>>>>>>>>>>>>>>>>>' + colorField);
		optionsColor.add(new SelectOption('--Select color--', '--Select color--'));
		for (Schema.PicklistEntry picklistEntry : colorField.getPicklistValues()) {
			optionsColor.add(new SelectOption(picklistEntry.getValue(), picklistEntry.getLabel()));
		}
		System.debug('3>>>>>>>>>>>>>>>>>>>>>>>>>>>' + optionsColor);
		return optionsColor;
	}

	public List<SelectOption> getSelectShowroom() {
		List<SelectOption> optionsShowroom = new List<SelectOption>();
		List<Showroom__c> shList = new List<Showroom__c>();
		shList = [SELECT Id, Name FROM Showroom__c];
		optionsShowroom.add(new SelectOption('--Select showroom--', '--Select showroom--'));
		for (Showroom__c showroom : shList) {
			optionsShowroom.add(new SelectOption(showroom.Name, showroom.Name));
		}
		System.debug('66666>>>>>>>>>>>>>>>>>>>>>>>>>>>' + optionsShowroom);
		return optionsShowroom;
	}
}
