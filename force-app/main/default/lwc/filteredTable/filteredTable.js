import { LightningElement, wire, api, track } from "lwc";
import getCases from "@salesforce/apex/FilteredTableController.getCases";
import { NavigationMixin } from "lightning/navigation";
import { refreshApex } from "@salesforce/apex";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

import { getPicklistValues } from "lightning/uiObjectInfoApi";
import COLOR_FIELD from "@salesforce/schema/Car__c.Color__c";

export default class FilteredTable extends NavigationMixin(LightningElement) {
	@track data;
	searchable = [];
	wiredCaseCount;
	wiredCases;

	doneTypingInterval = 0;
	colorPickListValues;
	priorityPickListValues;

	searchAllValue;

	caseNumber = "";
	accountName = "";
	contactName = "";
	subject = "";
	color = null;
	priority = null;

	@wire(getCases, {
		caseNumber: "$caseNumber",
		accountName: "$accountName",
		contactName: "$contactName",
		subject: "$subject",
		color: "$color",
		priority: "$priority"
	})
	wiredSObjects(result) {
		console.log("wire getting called");
		this.wiredCases = result;
		if (result.data) {
			this.searchable = this.data = result.data.map((caseObj, index) => ({
				caseData: { ...caseObj },
				index: index + 1,
				rowIndex: index
			}));
		} else if (result.error) {
			console.error("Error", error);
		}
	}

	@wire(getPicklistValues, {
		recordTypeId: "012000000000000AAA",
		fieldApiName: COLOR_FIELD
	})
	colorPickLists({ error, data }) {
		if (error) {
			console.error("error", error);
		} else if (data) {
			this.colorPickListValues = [{ label: "All", value: null }, ...data.values];
		}
	}

	handleChange(event) {
		this[event.target.name] = event.target.value;
		console.log("change", this[event.target.name]);
	}

	handleKeyUp(event) {
		clearTimeout(this.typingTimer);
		let value = event.target.value;
		let name = event.target.name;

		this.typingTimer = setTimeout(() => {
			this[name] = value;
		}, this.doneTypingInterval);
	}

	clearSearch() {
		this.color = null;
		this.searchAll();
	}

	handleSearchAll(event) {
		this.searchAllValue = event.target.value;
		this.searchAll();
	}

	searchAll() {
		let searchStr = this.searchAllValue.toLowerCase();
		const regex = new RegExp("(^" + searchStr + ")|(." + searchStr + ")|(" + searchStr + "$)");
		if (searchStr.length > 2) {
			this.searchable = this.data.filter((item) => {
				if (
					regex.test(item.caseData.Color__c?.toLowerCase() + " " + item.caseData.Color__c?.toLowerCase()
					)
				) {
					return item;
				}
			});
		} else if (this.caseNumber.length <= 2) {
			this.searchable = this.data;
		}
		console.log(this.searchable);
	}

	handleNavigate(event) {
		event.preventDefault();
		this[NavigationMixin.Navigate]({
			type: "standard__recordPage",
			attributes: {
				actionName: "view",
				recordId: event.target.dataset.id
			}
		});
	}
}
