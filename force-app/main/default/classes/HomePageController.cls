public class HomePageController {
	public String colorPickValue { get; set; }
	public String showroomPickValue { get; set; }
	public String recordId {get;set;}
	public List<Car__c> carsList { get; set; }


	public void getCars() {
		carsList = new List<Car__c>(
			[
				SELECT Id, Name, Model__c, Color__c, Price__c, Showroom__r.Name, Car_Owner__r.Name
				FROM Car__c
				WHERE Color__c = :colorPickvalue 
				AND Showroom__r.Name = :showroomPickValue
				LIMIT 50
			]
		);
		System.debug('1>>>>>>>>>>>>>>>>>>>>>>>>>>>' + carsList);
	}

	public List<SelectOption> getSelectColor(){
		List<SelectOption> optionsColor = new List<SelectOption>();
		Schema.DescribeFieldResult statusFieldDescription = Car__c.Color__c.getDescribe(); 
		optionsColor.add(new SelectOption('--Select color--','--Select color--'));
		for (Schema.PicklistEntry picklistEntry : statusFieldDescription.getPicklistValues()) {
			optionsColor.add(new SelectOption(picklistEntry.getValue(), picklistEntry.getLabel()));
		}
		return optionsColor;
	}

	public List<SelectOption> getSelectShowroom(){
		List<SelectOption> optionsShowroom = new List<SelectOption>();
		Schema.DescribeFieldResult statusFieldDescription = Car__c.Showroom__c.getDescribe();// возможно этот метод для типа picklist
		optionsShowroom.add(new SelectOption('--Select showroom--','--Select showroom--'));
		for (Schema.PicklistEntry picklistEntry : statusFieldDescription.getPicklistValues()) { //попробуй поменять метод
			optionsShowroom.add(new SelectOption(picklistEntry.getValue(), picklistEntry.getLabel()));
		}
		return optionsShowroom;
	}

	public PageReference getCarDetail() { 
		recordId = System.currentPageReference().getParameters().get('Id');
		System.debug('3>>>>>>>>>>>>>>>>>>>>>>>>>>>' + recordId);
    	//PageReference nextpage = new PageReference('/CarDetailPage/'+id);
        return null;
		//return new PageReference('/CarDetailPage');
		
	}

}
/* убрать hardcode from Color__c
перенаправление на URL CarDetailPage/id - car.id
*/