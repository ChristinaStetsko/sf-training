import { LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { NavigationMixin } from "lightning/navigation";
import { createRecord } from "lightning/uiRecordApi";

import CONTACT_OBJECT from "@salesforce/schema/Contact";
import FIRST_NAME_FIELD from "@salesforce/schema/Contact.FirstName";
import LAST_NAME_FIELD from "@salesforce/schema/Contact.LastName";
import EMAIL_FIELD from "@salesforce/schema/Contact.Email";
import PASSWORD_FIELD from "@salesforce/schema/Contact.Password__c";

export default class Registration extends NavigationMixin(LightningElement) {
	firstNameValue;
	lastNameValue;
	emailValue;
	passwordValue;
	userId;

	handleChange(event) {
		if (event.target.name === "FirstName") {
			this.firstNameValue = event.target.value;
		}
		if (event.target.name === "LastName") {
			this.lastNameValue = event.target.value;
		}
		if (event.target.name === "Email") {
			this.emailValue = event.target.value;
		}
		if (event.target.name === "Password") {
			this.passwordValue = event.target.value;
		}
	}

	createContact() {
		const fields = {};
		fields[FIRST_NAME_FIELD.fieldApiName] = this.firstNameValue;
        fields[LAST_NAME_FIELD.fieldApiName] = this.lastNameValue;
		fields[EMAIL_FIELD.fieldApiName] = this.emailValue;
		fields[PASSWORD_FIELD.fieldApiName] = this.passwordValue;

		const recordInput = {
			apiName: CONTACT_OBJECT.objectApiName,
			fields
		};

		createRecord(recordInput)
			.then((contact) => {
				this.userId = contact.id;

				this.dispatchEvent(
					new ShowToastEvent({
						title: "Success",
						message: "Successfully Registered " + this.lastNameValue + " " + this.firstNameValue,
						variant: "success"
					})
				);
			})
			.catch((error) => {
				this.dispatchEvent(
					new ShowToastEvent({
						title: "Error creating contact",
						message: error.body.message,
						variant: "error"
					})
				);
			});
	}

	handleLoginClick() {
		 // Navigate to the account object home page.
         this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Account',
                actionName: 'home'
            }
        });
	}
}
