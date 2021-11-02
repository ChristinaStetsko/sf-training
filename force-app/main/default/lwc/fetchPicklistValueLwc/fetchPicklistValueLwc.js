import { LightningElement, track, wire } from "lwc";
import pickListValueDynamically from "@salesforce/apex/lwcPicklistController.pickListValueDynamically";

export default class FetchPicklistValueLwc extends LightningElement {
	@track picklistVal;

	@wire(pickListValueDynamically, {
		customObjInfo: { sobjectType: "Car__c" },
		selectPicklistApi: "Color__c"
	})
	selectTargetValues;

	selectOptionChanveValue(event) {
		this.picklistVal = event.target.value;
	}
}
