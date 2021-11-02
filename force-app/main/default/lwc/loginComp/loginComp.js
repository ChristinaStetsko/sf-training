import { LightningElement } from "lwc";
import findContacts from "@salesforce/apex/LoginLWCController.findContacts";

export default class LoginComp extends LightningElement {
	searchEmail = '';
	searchPassword = '';
    contacts;
    error;

    handleEmailChange(event) {
        this.searchEmail = event.target.value;
    }

    handlePasswordChange(event) {
        this.searchPassword = event.target.value;
    }

    handleSearch() {
        findContacts({ searchEmail: this.searchEmail, searchPassword: this.searchPassword })
            .then((result) => {
                this.contacts = result;
                this.error = undefined;
            })
            .catch((error) => {
                this.error = error;
                this.contacts = undefined;
            });
    }
}
