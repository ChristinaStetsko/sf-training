public class HomePageController {
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

	public void getCars() {
		getAllCars = new List<Car__c>(
			[
				SELECT Id, Name, Model__c, Color__c, Price__c, Showroom__r.Name, Car_Owner__r.Name
				FROM Car__c
				WHERE Color__c = :colorPickvalue AND Showroom__r.Name = :showroomPickValue
				LIMIT 50
			]
		);
		System.debug('1>>>>>>>>>>>>>>>>>>>>>>>>>>>' + getAllCars);
	}

	//Filteres goes here:
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

	
	public PageReference forwardToSchedule() {
		return new PageReference('/SchedulePage');
	}
}